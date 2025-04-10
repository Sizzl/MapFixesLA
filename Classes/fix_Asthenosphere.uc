//=============================================================================
// Asthenosphere/AL - timo@utassault.net - '//3iRd(o) 2004
//=============================================================================
class fix_Asthenosphere extends MapFix config(MapFixes);

var bool bTweaked;
var() config bool bEnabled;
var() config bool bDebug;


function BeginPlay()
{
	Super.BeginPlay();
	if (!bTweaked)
	{
		bTweaked = True;
		if (bEnabled)
		{
			if (bIncludeLAS140Tweaks)
			{
 				fixAsthenoSpawns();
 				fixAsthenoObjects();
 			}
 		}
 	}
}
function fixAsthenoObjects()
{
	local Dispatcher D;
	local string S;
	local string SA;
	local Mover M;
	local ShockCore SC;
	local RocketPack RP;
	local FortStandard FS;
	local TeamCannon TC;
	local ThighPads TP;
	local Vector V;
	local Rotator R;
	
		
	S = Left(Self, InStr(Self, "."));
	if(S~="AS-Asthenosphere")
	{	
		foreach AllActors(class'Mover', M)
		{
			SA = Mid(string(M),InStr(string(M),".") + 1);
			if ( (SA ~= "Mover21") || (SA ~= "Mover26") )
			{
				M.MoverEncroachType = ME_IgnoreWhenEncroach; // 2;
			}
			if ( (SA ~= "Mover0") || (SA ~= "Mover2") || (SA ~= "Mover3") || (SA ~= "Mover4") || (SA ~= "Mover17") || (SA ~= "Mover18") || (SA ~= "Mover19") || (SA ~= "Mover20") || (SA ~= "Mover32") || (SA ~= "Mover35") )
			{
				M.MoverEncroachType = ME_CrushWhenEncroach; // 3;
			}
		}
		foreach AllActors(class'ShockCore', SC)
		{
			SA = Mid(string(SC),InStr(string(SC),".") + 1);
			if ( (SA ~= "ShockCore4") || (SA ~= "ShockCore15") )
				SC.Destroy();
			if ( (SA ~= "ShockCore20") || (SA ~= "ShockCore19") || (SA ~= "ShockCore11") || (SA ~= "ShockCore12") )
			{
				Level.Game.BaseMutator.ReplaceWith(SC,"BotPack.HealthVial");
				SC.Destroy();
			} 
		}
		foreach AllActors(class'RocketPack', RP)
		{
			SA = Mid(string(RP),InStr(string(RP),".") + 1);
			if ( (SA ~= "RocketPack9") || (SA ~= "RocketPack11") )
				RP.Destroy();
		}
		foreach AllActors(class'FortStandard', FS)
		{
			SA = Mid(string(FS),InStr(string(FS),".") + 1);
			if ( SA ~= "FortStandard8" )
			{
				V.X = 0.0;
				V.Y = -5628.0;
				V.Z = 40.4153;
				R.Pitch = 0;
				R.Roll = 0;
				R.Yaw = -16264;
				TC = Spawn(Class'TeamCannon',FS,FS.Tag,V,R);
				TC.MyTeam = 1;
				TC.ProjectileType = Class'ShockProj';
				V.Y = -4848.0;
				TC = Spawn(Class'TeamCannon',FS,FS.Tag,V,R);
				TC.ProjectileType = Class'RocketMk2';
				V.X = -336.0;
				V.Y = -11800.0;
				V.Z = -32.0;
				R.Pitch = 0;
				R.Roll = 0;
				R.Yaw = 0;
				TP = Spawn(Class'ThighPads',FS,FS.Tag,V,R);
				V.X = 336.0;
				V.Y = -11800.0;
				V.Z = -32.0;
				R.Pitch = 0;
				R.Roll = 0;
				R.Yaw = 0;
				TP = Spawn(Class'ThighPads',FS,FS.Tag,V,R);
			}
		}		
	}
}

function fixAsthenoSpawns()
{
	local Dispatcher D;
	local string S;
	local string SA;
	
	S = Left(Self, InStr(Self, "."));
	if(S~="AS-Asthenosphere" || S~="AS-AsthenosphereAL") {
		if (bDebug) log("AssSpam-O-Crap Dispatcher Change Start...");
		foreach AllActors(class'Dispatcher', D)
		{
			SA = Mid(D, InStr(D, ".") + 1);
			if (SA~="Dispatcher2")
			{
				if (bDebug) log(D.Name$" was "$D.OutEvents[0]$", "$D.OutEvents[1]);
				D.OutEvents[0] = 'spawn3';	
				D.OutEvents[1] = 'spawn2';		
				if (bDebug) log(D.Name$" now "$D.OutEvents[0]$", "$D.OutEvents[1]);
			}
			
		}
		if (bDebug) log("AssSpam-O-Crap Dispatcher Change made...");
	
	}
	
}

defaultproperties
{
     bEnabled=True
     bHidden=True
}
