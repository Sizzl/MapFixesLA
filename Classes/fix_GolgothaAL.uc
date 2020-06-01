//===============================================================================================
// AS-GolgothaAL - timo@utassault.net - 2007
//===============================================================================================
class fix_GolgothaAL extends MapFix config(MapFixesLA11);

var bool bTweaked;
var() config bool bEnabled;
var() config bool bDebug;

function BeginPlay()
{
	local string S;
	Super.BeginPlay();
	if (!bTweaked)
	{
		bTweaked = True;
		S = Left(Self, InStr(Self, "."));
		if (bEnabled && S~="AS-GolgothaAL")
		{
			fixGolALBlackspots();
		
		}
	}
}

function fixGolALBlackspots() {
	local vector BlackspotV[2];
	local float  BlackspotR[2];
	local float  BlackspotH[2];
	
	local vector KickerV[8];
	local float  KickerR[8];
	local float  KickerH[8];

	local int i;
	local RelevancyTrigger RT;
	local Kicker KR;

	BlackspotV[0] = vect(-1120.000000,-4960.000000,-1312.000000);	BlackspotR[0] = 600.000000; BlackspotH[0] = 200.000000;
	BlackspotV[1] = vect(-960.000000,-5904.000000,-1312.000000);	BlackspotR[1] = 600.000000; BlackspotH[1] = 200.000000;

	KickerV[0] = vect(-2561.000000,-2950.000000,-1949.000000);	KickerR[0] = 150.000000; KickerH[0] = 20.000000;
	KickerV[1] = vect(-2849.000000,-2950.000000,-1949.000000);	KickerR[1] = 150.000000; KickerH[1] = 20.000000;
	KickerV[2] = vect(-2273.000000,-2950.000000,-1949.000000);	KickerR[2] = 150.000000; KickerH[2] = 20.000000;
	KickerV[3] = vect(-2041.000000,-2950.000000,-1949.000000);	KickerR[3] = 150.000000; KickerH[3] = 20.000000;
	KickerV[4] = vect(-1817.000000,-2950.000000,-1949.000000);	KickerR[4] = 150.000000; KickerH[4] = 20.000000;
	KickerV[5] = vect(-1537.000000,-2950.000000,-1949.000000);	KickerR[5] = 150.000000; KickerH[5] = 20.000000;
	KickerV[6] = vect(-1249.000000,-2950.000000,-1949.000000);	KickerR[6] = 150.000000; KickerH[6] = 20.000000;
	KickerV[7] = vect(-945.000000,-2950.000000,-1949.000000);	  KickerR[7] = 150.000000; KickerH[7] = 20.000000;

	if (bDebug) log("<-- GolAL Blackspot Fix");
	for (i=0; i <= 1; i++)
	{
		RT = Spawn(class'RelevancyTrigger',,, BlackspotV[i]);
		RT.SetCollisionSize(BlackspotR[i],BlackspotH[i]);
		if (bDebug) log("* Spawned RT - L:"@RT.Location@"/ R:"@RT.CollisionRadius@"/ H:"@RT.CollisionHeight);
	}
	if (bDebug) log("GolAL Blackspot Fix -->");
	if (bDebug) log("<-- GolAL Blood Wall Fix");
	for (i=0; i <= 7; i++)
	{
		KR = Spawn(class'Kicker',,, KickerV[i]);
		KR.SetCollisionSize(KickerR[i],KickerH[i]);
		KR.KickVelocity = vect(150.000000,150.000000,-80.000000);
		if (bDebug) log("* Spawned KR - L:"@KR.Location@"/ R:"@KR.CollisionRadius@"/ H:"@KR.CollisionHeight);
	}
	if (bDebug) log("GolAL Blood Wall Fix -->");
}

defaultproperties
{
     bEnabled=True
}
