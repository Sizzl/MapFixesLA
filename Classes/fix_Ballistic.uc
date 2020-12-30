//=============================================================================
// Ballistic - timo@utassault.net - '//3iRd(o) 2006
//=============================================================================
class fix_Ballistic extends MapFix config(MapFixesLA11);

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
	local vector BTVect[12];
	local float BTHeight[12];
	local float BTRadius[12];

	BTVect[0] = vect(-1202,-5576,-784); BTHeight[0]=500; BTRadius[0] = 55;
	BTVect[1] = vect(-1165,-5642,-784); BTHeight[1]=500; BTRadius[1] = 20;
	BTVect[2] = vect(-1239,-5642,-784); BTHeight[2]=500; BTRadius[2] = 20;
	BTVect[3] = vect(-785,-5679,-784);  BTHeight[3]=500; BTRadius[3] = 55;
	BTVect[4] = vect(-749,-5642,-784);  BTHeight[4]=500; BTRadius[4] = 20;
	BTVect[5] = vect(-823,-5642,-784);  BTHeight[5]=500; BTRadius[5] = 20;
	BTVect[6] = vect(-999,-5651,-384);  BTHeight[6]=100; BTRadius[6] = 95;
	BTVect[7] = vect(-858,-5651,-384);  BTHeight[7]=100; BTRadius[7] = 95;
	BTVect[8] = vect(-1130,-5651,-384); BTHeight[8]=100; BTRadius[8] = 95;
	BTVect[9] = vect(-785,-5693,-784);  BTHeight[8]=500; BTRadius[8] = 55;
	BTVect[10] = vect(-747,-5728,-784); BTHeight[8]=500; BTRadius[8] = 20;
	BTVect[11] = vect(-817,-5728,-784); BTHeight[8]=500; BTRadius[8] = 20;

	if (bDebug) log("<-- Ballistic Wall Fix #1");
	for (i=0; i <= 11; i++)
	{
		BT = Spawn(class'TriggeredBlockAll',,, BTVect[i]);
		BT.SetCollisionSize(BTRadius[i],BTHeight[i]);
		BT.SetMode(true,true,true,false,false,false);
		BT.bDebug = true;
		BT.Tag = 'bxWallBlock';
		if (bDebug) log("* Spawned BA - L:"@BT.Location@"/ R:"@BT.CollisionRadius@"/ H:"@BT.CollisionHeight);
	}
	if (bDebug) log("Ballistic Wall Fix #1 -->");
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
