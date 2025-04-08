//=============================================================================
// AutoRIP - timo@utassault.net - '//3iRd(o) 2006
//=============================================================================
class fix_AutoRIP extends MapFix config(MapFixesLA11);

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
		if (bEnabled && (Left(S,10) ~= "AS-AutoRIP"))
		{
		 		if (bIncludeLAS140Tweaks)
		 			fixLASAutoRIP();
 		}
 	}
}

function fixLASAutoRIP()
{
	local Actor A;
	local string SA;

	// Relevancy blackspot
	Spawn(Class'RelevancyTrigger',,,vect(2911.0,3060.0,-62.0)).SetCollisionSize( 250.0, 80.0 );

	// Fix actors
	foreach AllActors( Class'Actor', A )
	{
		SA = Left(A, InStr(A, "."));
		if ( SA~="TeamTrigger6" || SA~="TeamTrigger7" || SA~="TeamTrigger8" || SA~="TeamTrigger9" || SA~="TeamTrigger10" || SA~="TeamTrigger11" || SA~="TeamTrigger12" || SA~="TeamTrigger13" || SA~="TeamTrigger14" || SA~="TeamTrigger15" || SA~="TeamTrigger16" || SA~="TeamTrigger17" || SA~="TeamTrigger18" || SA~="TeamTrigger19" || SA~="TeamTrigger20" || SA~="TeamTrigger21" || SA~="TeamTrigger22" || SA~="TeamTrigger23" || SA~="PressureZone0" )
		{
			A.Destroy();
		}
		else if ( SA~="TeamTrigger2" )
		{
			A.SetCollisionSize( 64.0, A.CollisionHeight );
		}
		else if ( SA~="Mover4" )
		{
			A.Tag = 'HJDJSHTICHFK';
			Mover(A).DoOpen();
		}
		else if ( SA~="Trigger4" )
		{
			// This trigger sets up the test room, raising the shield
			// Attackers touch this just after first spawn, when navigating down the first ramp towards the train tracks
			// By default, it is not wide enough (and actually, is still not high enough - can be bypassed with a carefully placed hj)
			A.SetCollisionSize( 360.0, A.CollisionHeight );
		}
	}
}

defaultproperties
{
     bEnabled=True
}
