//===============================================================================================
// AS-Riverbed3AL - timo@utassault.net - 2007
//===============================================================================================
class fix_Riverbed3AL extends MapFix config(MapFixes);

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
		if (bEnabled && S~="AS-Riverbed]l[AL")
		{
			fixRiverbed3();
		
		}
	}
}

function fixRiverbed3() {
	local vector KickerV[32];
	local float  KickerR[32];
	local float  KickerH[32];

	local int i;
	local Kicker KR;

	KickerV[0] = vect(-2561.000000,-2950.000000,-1949.000000);	KickerR[0] = 150.000000; KickerH[0] = 20.000000;
	KickerV[1] = vect(-2849.000000,-2950.000000,-1949.000000);	KickerR[1] = 150.000000; KickerH[1] = 20.000000;
	KickerV[2] = vect(-2273.000000,-2950.000000,-1949.000000);	KickerR[2] = 150.000000; KickerH[2] = 20.000000;
	KickerV[3] = vect(-2041.000000,-2950.000000,-1949.000000);	KickerR[3] = 150.000000; KickerH[3] = 20.000000;
	KickerV[4] = vect(-1817.000000,-2950.000000,-1949.000000);	KickerR[4] = 150.000000; KickerH[4] = 20.000000;
	KickerV[5] = vect(-1537.000000,-2950.000000,-1949.000000);	KickerR[5] = 150.000000; KickerH[5] = 20.000000;
	KickerV[6] = vect(-1249.000000,-2950.000000,-1949.000000);	KickerR[6] = 150.000000; KickerH[6] = 20.000000;
	KickerV[7] = vect(-945.000000,-2950.000000,-1949.000000);	  KickerR[7] = 150.000000; KickerH[7] = 20.000000;

	if (bDebug) log("<-- Riv3 Wall Tweak");
	for (i=0; i <= 7; i++)
	{
		KR = Spawn(class'Kicker',,, KickerV[i]);
		KR.SetCollisionSize(KickerR[i],KickerH[i]);
		KR.KickVelocity = vect(150.000000,150.000000,-80.000000);
		if (bDebug) log("* Spawned KR - L:"@KR.Location@"/ R:"@KR.CollisionRadius@"/ H:"@KR.CollisionHeight);
	}
	if (bDebug) log("Riv3 Wall Tweak -->");
}

defaultproperties
{
     bEnabled=False
}
