//=============================================================================
// SnowdunesAL_preview - timo@utassault.net - '//3iRd(o) 2006
//=============================================================================
class fix_SnowdunesALpreview extends MapFix config(MapFixes);

var bool bTweaked;
var() config bool bDebug;
var() config bool bEnabled;

function BeginPlay()
{
	local string S;
	Super.BeginPlay();
	if (!bTweaked)
	{
		bTweaked = True;
		S = Left(Self, InStr(Self, "."));
		if (bEnabled && S~="AS-SnowdunesAL_preview")
		{
			fixSnowdunesBlocks();
		}
	}
}

function fixSnowdunesBlocks() {

	local Vector BlockSpot[5];
	local float BlockSpotR, BlockSpotH;
	local TriggeredBlockAll TB;
	local string SA;
	local int i;
	
	BlockSpot[0] = vect(4156.974609,-2480.983887,-653.000000);
	BlockSpot[1] = vect(4032.196533,-2296.879150,-653.000000);
	BlockSpot[2] = vect(4094.547363,-2373.578369,-653.000000);
	BlockSpot[3] = vect(3901.788574,-2187.179932,-653.000000);
	BlockSpot[4] = vect(3839.057617,-2041.466553,-653.000000);

	BlockspotR = 240.000000;
	BlockspotH = 15.000000;
	
	if (bDebug) log("<-- SnowdunesAL_preview Fixes");
	for (i=0; i <= 4; i++)
	{
		TB = Spawn(class'TriggeredBlockAll',,, Blockspot[i]);
		if (i==4) BlockspotR = 200;
		TB.SetCollisionSize(BlockspotR,BlockspotH);
		if (bDebug) log("* Spawned TB - L:"@TB.Location@"/ R:"@TB.CollisionRadius@"/ H:"@TB.CollisionHeight);
	}
	if (bDebug) log("SnowdunesAL_preview Fixes -->");
}

defaultproperties
{
     bEnabled=True
}
