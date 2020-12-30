//===============================================================================================
// AS-Bridge - timo@utassault.net - 2005-2007
//===============================================================================================
class fix_Bridge extends MapFix config(MapFixesLA11);

var bool bTweaked;
var() config float TreeRadiusFactor;
var() config bool bEnabled;
var() config bool bDebug;
var() config bool bFixCannons;
var() config bool bKillUWSpawn;
var() config bool bTweakTrees;

function BeginPlay()
{
	local string S;
	Super.BeginPlay();
	if (!bTweaked)
	{
		bTweaked = True;
		S = Left(Self, InStr(Self, "."));

		// Apply only to original Bridge
		if (bEnabled && S~="AS-Bridge")
		{
			if (bDebug) log("* Applying Bridge fixes...");

			fixBridgeBlackspots();
			if (bDebug) log("* Blackspot fixes applied.");
			
			if (bFixCannons)
			{
				fixBridgeCannons();
				if (bDebug) log("* Cannon fixes applied.");
			}
			if (bKillUWSpawn)
			{
				fixUWSpawn();
				if (bDebug) log("* Underwater Spawns killed.");
			}
			if (bIncludeLAS140Tweaks)
			{
				BridgeLASTweaks();
				if (bDebug) log("* LAS tweaks re-applied.");
			}
		}
		// Apply to all versions of Bridge
		if (bEnabled && LefT(S,9)~="AS-Bridge")
		{
			if (bTweakTrees)
			{
				tweakBridgeTrees();
				if (bDebug) log("* Tree collision changes applied.");
			}
		}
	}
}

function tweakBridgeTrees() {
	local Tree2 T2;
	local Tree3 T3;
	local Tree4 T4;
	local BlockAll TB;
	local string SA;
	local vector TBLocation;
	if (bDebug) log("<-- Bridge Tree Fixes");
	foreach AllActors(Class'UnrealShare.Tree2',T2)
	{
		SA = Mid(string(T2),InStr(string(T2),".") + 1);
		TBLocation = (T2.Location)-vect(0,0,325);

		T2.SetCollision(true,true,true); // Set all trees collide with everything

		// SetCollisionSize(R,H)
		T2.SetCollisionSize(TreeRadiusFactor*T2.DrawScale,160);
		TB = Spawn(class'TriggeredBlockAll',,, TBLocation);
		TB.SetCollisionSize(T2.CollisionRadius,200);
		if (bDebug)
		{
			log("* Spawned BlockAll underneath "$SA$" - L:"@TB.Location@"/ R:"@TB.CollisionRadius@"/ H:"@TB.CollisionHeight);
			TB.bHidden = false;
			TB.DrawScale = T2.DrawScale+1;
		}

	}

	foreach AllActors(Class'UnrealShare.Tree3',T3)
	{
		SA = Mid(string(T3),InStr(string(T3),".") + 1);
		TBLocation = (T3.Location)-vect(0,0,325);

		T3.SetCollision(true,true,true); // Set all trees collide with everything
		T3.SetCollisionSize(TreeRadiusFactor*T3.DrawScale,160);
		TB = Spawn(class'TriggeredBlockAll',,, TBLocation);
		TB.SetCollisionSize(T3.CollisionRadius,200);
		if (bDebug)
		{
			log("* Spawned BlockAll underneath "$SA$" - L:"@TB.Location@"/ R:"@TB.CollisionRadius@"/ H:"@TB.CollisionHeight);
			TB.bHidden = false;
			TB.DrawScale = T3.DrawScale+1;
		}

	}

	foreach AllActors(Class'UnrealShare.Tree4',T4)
	{
		SA = Mid(string(T4),InStr(string(T4),".") + 1);
		TBLocation = (T4.Location)-vect(0,0,325);

		T4.SetCollision(true,true,true); // Set all trees collide with everything
		T4.SetCollisionSize(TreeRadiusFactor*T4.DrawScale,160);
		TB = Spawn(class'TriggeredBlockAll',,, TBLocation);
		TB.SetCollisionSize(T4.CollisionRadius,200);
		if (bDebug)
		{
			log("* Spawned BlockAll underneath "$SA$" - L:"@TB.Location@"/ R:"@TB.CollisionRadius@"/ H:"@TB.CollisionHeight);
			TB.bHidden = false;
			TB.DrawScale = T4.DrawScale+1;
		}
	}
	if (bDebug) log("Bridge Tree Fixes -->");

}

function BridgeLASTweaks() {
	local RelevancyTrigger RT;
	local FortStandard FS;
	local Mover M;
	local ThighPads TP;
	local BreakingGlass BG;
	local string SA;
	local TeamTrigger T;
	local Vector V;
	
	Spawn(Class'RelevancyTrigger',,,vect(-515.00,-3640.00,620.00)).SetCollisionSize(128.0,80.0);
	Spawn(Class'RelevancyTrigger',,,vect(1218.80,-3517.26,306.10)).SetCollisionSize(132.0,132.0);

	foreach AllActors(Class'FortStandard',FS)
	{
		SA = Mid(string(FS),InStr(string(FS),".") + 1);
		if ( SA ~= "FortStandard3" )
		{
			FS.FortName = "The base";
			FS.DestroyedMessage = "has been entered!";
		}
		else if ( SA ~= "FortStandard7" )
		{
			FS.FortName = "The bridge";
			FS.DestroyedMessage = "has been reached!";
		}
		else if ( SA ~= "FortStandard22" )
		{
			FS.SetCollisionSize(FS.CollisionRadius * 2 / 3,FS.CollisionHeight);
			V.X = 2768.0;
			V.Y = -1255.0;
			V.Z = 1478.0;
			T = Spawn(Class'TeamTrigger',FS,FS.Tag,V,FS.Rotation);
			T.Team = 0;
			T.Event = 'FF';
		}
	}
	foreach AllActors(Class'Mover',M)
	{
		SA = Mid(string(M),InStr(string(M),".") + 1);
		if ( (SA ~= "Mover16") || (SA ~= "Mover17") || (SA ~= "Mover18") || (SA ~= "Mover19") )
		{
			M.SetCollision(False);
		}
	}
	foreach AllActors(Class'ThighPads',TP)
	{
		SA = Mid(string(TP),InStr(string(TP),".") + 1);
		if ( SA ~= "ThighPads0" )
			TP.bRotatingPickup = False;
	}
	foreach AllActors(Class'BreakingGlass',BG)
	{
		if ( SA ~= "BreakingGlass0" )
		{
				BG.SetCollision(False);
		}
	}
}
function fixBridgeBlackspots() {
	local vector BlackspotV[6];
	local float  BlackspotR[6];
	local float  BlackspotH[6];
	local int i;
	local RelevancyTrigger RT;
	
	BlackspotV[0] = vect(734.000000,-5712.000000,144.000000); BlackspotR[0] = 30.000000; BlackspotH[0] = 30.000000;
	BlackspotV[1] = vect(686.426147,-5712.000000,144.000000); BlackspotR[1] = 30.000000; BlackspotH[1] = 30.000000;
	BlackspotV[2] = vect(155.852341,-5728.000000,144.000000); BlackspotR[2] = 40.000000; BlackspotH[2] = 30.000000;
	BlackspotV[3] = vect(273.278503,-5712.000000,144.000000); BlackspotR[3] = 25.000000; BlackspotH[3] = 30.000000;
	BlackspotV[4] = vect(638.000000,-5712.000000,144.000000); BlackspotR[4] = 30.000000; BlackspotH[4] = 30.000000;
	BlackspotV[5] = vect(221.000000,-5728.000000,128.000000); BlackspotR[5] = 35.000000; BlackspotH[5] = 30.000000;
	if (bDebug) log("<-- Bridge Blackspot Fix");
	for (i=0; i <= 5; i++)
	{
		RT = Spawn(class'RelevancyTrigger',,, BlackspotV[i]);
		RT.SetCollisionSize(BlackspotR[i],BlackspotH[i]);
		if (bDebug) log("* Spawned RT - L:"@RT.Location@"/ R:"@RT.CollisionRadius@"/ H:"@RT.CollisionHeight);
	}
	if (bDebug) log("Bridge Blackspot Fix -->");
	
}

function fixBridgeCannons() {

	local TeamCannon T;
	local string S;
	local string SA;
	if (bDebug) log("<-- Bridge AutoCannon Fix");
	foreach AllActors(class'TeamCannon',T)
	{
		SA = Mid(T, InStr(T, ".") + 1);
		if (SA~="TeamCannon1")
		{
			T.SetLocation(vect(3172.317383,-1586.567749,1904.000000));
		}
	}
	if (bDebug) log("<-- Bridge AutoCannon Fix");	
}

function fixUWSpawn()
{
	local Dispatcher D;
	local SpecialEvent S;
	local TeamTrigger T;
	local Counter C;
	local Actor A;
	local PlayerStart P;
	
	foreach AllActors( class 'PlayerStart', P )
		{
			if( P.Tag == 'SP1')
			{
				P.Event = 'uwSpawner';
			}
			
			if( P.Name == 'PlayerStart7' )
			{
				P.Tag = 'sp1_5';
				P.bEnabled = false;
			}
			else if( P.Name == 'PlayerStart8' )
			{
				P.Tag = 'sp1_5';
				P.bEnabled = false;
			}			
			else if( P.Name == 'PlayerStart9' )
			{
				P.Tag = 'sp1_5';
				P.bEnabled = false;
			}
			else if( P.Name == 'PlayerStart21' )
			{
				P.Tag = 'sp1_5';
				P.bEnabled = false;
				C = Spawn(class'Counter', Self, 'enDiSpawns', P.Location, P.Rotation);
				if ( C != None )
				{
					C.Tag = 'enDiSpawns';
					C.bShowmessage = true;
					C.NumToCount = 10;
					C.Event = 'sp1_5';
				}
				if ( C != None )
				{
					C.Tag = 'enDiSpawns';
					C.bShowmessage = true;
					C.NumToCount = 4;
					C.Event = 'sp1';
				}				

			}
			else {
				
			}
		}
		foreach AllActors( class 'Dispatcher', D )
		{
			if(D.Name == 'Dispatcher0')
			{
				D.OutDelays[0] = 0;
				D.OutDelays[1] = 0;
				D.OutDelays[2] = 0;
				D.OutDelays[3] = 6;
				D.OutDelays[4] = 0;
				
				D.OutEvents[0] = 'sp2';
				D.OutEvents[1] = 'enDiSpawns';
				D.OutEvents[2] = 'motor';
				D.OutEvents[3] = 'chains';
				D.OutEvents[4] = 'maindoorfort';
				
			}
		}
}

defaultproperties
{
     bEnabled=True
     bTweakTrees=True
     TreeRadiusFactor=20
}
