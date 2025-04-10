//=============================================================================
// Ballistic - timo@utassault.net - '//3iRd(o) 2006
//=============================================================================
class fix_Ballistic extends MapFix config(MapFixes);

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
		if (bEnabled && (Left(S,12) ~= "AS-Ballistic"))
		{
			 	fixTele_ThanksToMyM();
		 		fixWalls();
		 		if (bIncludeLAS140Tweaks)
		 			fixBallisticObjects();
 		}
 	}
}

function fixBallisticObjects()
{
    Spawn(Class'BlockVent',,,vect(-1003.00,-3938.00,-300.00)).Tag = 'powerdestroyed';
    Spawn(Class'RelevancyTrigger',,,vect(-784.00,-3254.00,-689.00)).SetCollisionSize(250.0,80.0);
}

function fixWalls()
{
	local TriggeredBlockAll BT;
	local int i;
	local vector BTVect[32];
	local float BTHeight[32];
	local float BTRadius[32];

	// Pillar 1
	BTVect[0] = vect(-1202,-5670,-784); BTHeight[0]=500; BTRadius[0] = 55;
	BTVect[1] = vect(-1165,-5642,-784); BTHeight[1]=500; BTRadius[1] = 20;
	BTVect[2] = vect(-1239,-5642,-784); BTHeight[2]=500; BTRadius[2] = 20;
	BTVect[3] = vect(-1220,-5645,-784); BTHeight[3]=500; BTRadius[3] = 20;
	BTVect[4] = vect(-1186,-5645,-784); BTHeight[4]=500; BTRadius[4] = 20;

	// Pillar 2
	BTVect[5] = vect(-785,-5670,-784);  BTHeight[5]=500; BTRadius[5] = 55;
	BTVect[6] = vect(-749,-5642,-784);  BTHeight[6]=500; BTRadius[6] = 20;
	BTVect[7] = vect(-823,-5642,-784);  BTHeight[7]=500; BTRadius[7] = 20;
	BTVect[8] = vect(-805,-5645,-784); BTHeight[8]=500; BTRadius[8] = 20;
	BTVect[9] = vect(-770,-5645,-784); BTHeight[9]=500; BTRadius[9] = 20;

	// Arch
	BTVect[10] = vect(-999,-5651,-384);  BTHeight[10]=100; BTRadius[10] = 95;
	BTVect[11] = vect(-858,-5651,-384);  BTHeight[11]=100; BTRadius[11] = 95;
	BTVect[12] = vect(-1130,-5651,-384); BTHeight[12]=100; BTRadius[12] = 95;
	BTVect[13] = vect(-785,-5693,-784);  BTHeight[13]=500; BTRadius[13] = 55;
	BTVect[14] = vect(-747,-5728,-784); BTHeight[14]=500; BTRadius[14] = 20;
	BTVect[15] = vect(-817,-5728,-784); BTHeight[15]=500; BTRadius[15] = 20;

	// WL Pillar Tops
	BTVect[16] = vect(-2292,-2890,-435); BTHeight[16]=50; BTRadius[16] = 20;
	BTVect[17] = vect(-2292,-2855,-435); BTHeight[17]=50; BTRadius[17] = 20;
	
	BTVect[18] = vect(-2292,-2700,-435); BTHeight[18]=50; BTRadius[18] = 20;
	BTVect[19] = vect(-2292,-2665,-435); BTHeight[19]=50; BTRadius[19] = 20;
	
	BTVect[20] = vect(-2292,-2505,-435); BTHeight[20]=50; BTRadius[20] = 20;
	BTVect[21] = vect(-2292,-2470,-435); BTHeight[21]=50; BTRadius[21] = 20;
	
	BTVect[22] = vect(-2415,-2346,-435); BTHeight[22]=50; BTRadius[22] = 20;
	BTVect[23] = vect(-2450,-2346,-435); BTHeight[23]=50; BTRadius[23] = 20;
	
	BTVect[24] = vect(-2610,-2346,-435); BTHeight[24]=50; BTRadius[24] = 20;
	BTVect[25] = vect(-2645,-2346,-435); BTHeight[25]=50; BTRadius[25] = 20;
	
	BTVect[26] = vect(-2805,-2346,-435); BTHeight[26]=50; BTRadius[26] = 20;
	BTVect[27] = vect(-2840,-2346,-435); BTHeight[27]=50; BTRadius[27] = 20;

	if (bDebug) log("<-- Ballistic Wall Fixes");
	for (i=0; i <= 31; i++)
	{
		if (BTHeight[i] > 0 && BTRadius[i] > 0)
		{
			BT = Spawn(class'TriggeredBlockAll',,, BTVect[i]);
			BT.SetCollisionSize(BTRadius[i],BTHeight[i]);
			BT.SetMode(true,true,true,false,false,false);
			BT.bDebug = bDebug;
			BT.Tag = 'bxWallBlock';
			if (bDebug) log("* Spawned Wall Block - L:"@BT.Location@"/ R:"@BT.CollisionRadius@"/ H:"@BT.CollisionHeight);
		}
	}
	if (bDebug) log("Ballistic Wall Fixes -->");
}

function fixTele_ThanksToMyM()
{
  	local Dispatcher D;

	foreach AllActors( class 'Dispatcher', D )
	{
		if( D.Tag == 'latchtele' ) {
			D.OutEvents[1] = 'teamtele';
	 	}
	}
}

defaultproperties
{
     bEnabled=True
}
