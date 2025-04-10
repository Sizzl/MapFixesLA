//=============================================================================
// Desolate][ - timo@utassault.net - '//3iRd(o) 2004
//=============================================================================
class fix_Desolate2 extends MapFix config(MapFixes);

var bool bTweaked;
var config bool bDebug;
var config bool bEnabled;

function BeginPlay()
{
	local string S;
	Super.BeginPlay();
	if (!bTweaked)
	{
		bTweaked = True;
		S = Left(Self, InStr(Self, "."));
		if (bEnabled && S~="AS-Desolate][")
		{
			if (bIncludeLAS140Tweaks)
				fixD2Spawns();
			fixDesolateObjs();
		}
	}
}

function fixDesolateObjs() {

	local Vector BlockSpotV;
	local float BlockSpotR, BlockSpotH;
	local TriggeredBlockAll TB;
	local Pipe P;
	local string SA;
	
	BlockSpotV = vect(-1673.081787,2372.740967,-894.175842);	BlockspotR = 1400.000000; BlockspotH = 10.000000;
	
	if (bDebug) log("<-- Desolate][ Fixes");
	TB = Spawn(class'TriggeredBlockAll',,, BlockspotV);
	TB.SetCollisionSize(BlockspotR,BlockspotH);
	if (bDebug) log("* Spawned TB - L:"@TB.Location@"/ R:"@TB.CollisionRadius@"/ H:"@TB.CollisionHeight);


	foreach AllActors(class'Pipe', P)
	{
		if (P.Name == 'Pipe89' || P.Name == 'Pipe90' || P.Name == 'Pipe97')
		{
			P.SetCollisionSize(50.0,300.0);
			if (bDebug) log("* "$P.Name$" Altered - L:"@P.Location@"/ R:"@P.CollisionRadius@"/ H:"@P.CollisionHeight);
		}
		if (P.Name == 'Pipe50' || P.Name == 'Pipe51' )
		{
			P.SetCollisionSize(30.0,70.00);
			if (bDebug) log("* "$P.Name$" Altered - L:"@P.Location@"/ R:"@P.CollisionRadius@"/ H:"@P.CollisionHeight);
		}
		if (P.Name == 'Pipe4' || P.Name == 'Pipe7' || P.Name == 'Pipe9' || P.Name == 'Pipe10' || P.Name == 'Pipe11' || P.Name == 'Pipe12' || P.Name == 'Pipe13' || P.Name == 'Pipe14' || P.Name == 'Pipe15' || P.Name == 'Pipe16' || P.Name == 'Pipe17' || P.Name == 'Pipe18' || P.Name == 'Pipe19' || P.Name == 'Pipe20' || P.Name == 'Pipe21' || P.Name == 'Pipe25' || P.Name == 'Pipe26' || P.Name == 'Pipe27' || P.Name == 'Pipe28' || P.Name == 'Pipe29' || P.Name == 'Pipe46' || P.Name == 'Pipe47' || P.Name == 'Pipe48' || P.Name == 'Pipe49' || P.Name == 'Pipe42' || P.Name == 'Pipe43' || P.Name == 'Pipe44' || P.Name == 'Pipe45' || P.Name == 'Pipe38' || P.Name == 'Pipe39' || P.Name == 'Pipe40' || P.Name == 'Pipe41' || P.Name == 'Pipe34' || P.Name == 'Pipe35' || P.Name == 'Pipe36' || P.Name == 'Pipe37' || P.Name == 'Pipe30' || P.Name == 'Pipe31' || P.Name == 'Pipe32' || P.Name == 'Pipe33')
		{
			P.SetCollisionSize(48.0,800.0);
			if (bDebug) log("* "$P.Name$" Altered - L:"@P.Location@"/ R:"@P.CollisionRadius@"/ H:"@P.CollisionHeight);
		}
	}
	if (bDebug) log("Desolate][ Fixes -->");
}

function fixD2Spawns() {
	local Dispatcher D;
	local string S;
	local string SA;
	
	if (bDebug) log("Desolate][ Dispatcher Changes Start...");
	foreach AllActors(class'Dispatcher', D)
	{
		SA = Mid(D, InStr(D, ".") + 1);
		if (SA~="Dispatcher0")
		{
			D.OutEvents[2] = 'newspawn';	
			D.OutEvents[3] = 'A2';		
			if (bDebug) log(D.Name);
		}
		else if (SA~="Dispatcher1")
		{
			D.OutEvents[0] = 'A3';	
			D.OutEvents[1] = 'newspawn';		
			if (bDebug) log(D.Name);
		}
		else if (SA~="Dispatcher4")
		{
			D.OutEvents[0] = 'attackfinal';	
			D.OutEvents[1] = 'a4';	
			if (bDebug) log(D.Name);
		}
		else if (SA~="Dispatcher5")
		{
			D.OutEvents[0] = 'A3';	
			D.OutEvents[1] = 'newspawn';		
			if (bDebug) log(D.Name);
		}
		else if (SA~="Dispatcher8")
		{
			D.OutEvents[0] = 'A2';	
			D.OutEvents[1] = 'A1';
			if (bDebug) log(D.Name);
		}
		
		
	}
	if (bDebug) log("Desolate][ Dispatcher Changes made...");
}

defaultproperties
{
     bEnabled=True
}
