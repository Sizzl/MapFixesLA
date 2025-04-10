//===============================================================================================
// AS-TheDungeons3(betas) - timo@utassault.net - 2007
//===============================================================================================
class fix_TheDungeons3Betas extends MapFix config(MapFixes);

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
		if (bEnabled && (S~="TheDungeon]l[beta2" || S~="AS-TheDungeon]l[beta2_e" || S~="AS-Dungeon]l[ALbeta2"))
		{
			fixDungeonDoor();
		}
	}
}

function fixDungeonDoor() {

	local int i;
	local Mover M;
	local Dispatcher D;
	
	if (bDebug) log("<-- Dungeon Door Fix");
	foreach AllActors( class 'Mover',M )
	{
		if ( M.Name == 'Mover3' ) {
			M.MoverEncroachType = ME_CrushWhenEncroach;
			M.StayOpenTime = 99999;
			M.InitialState = 'TriggerOpenTimed';
		}
	}
 foreach AllActors( class 'Dispatcher',D )
	{
		if ( D.Name == 'Dispatcher7' ) {
			D.Destroy();
		}
	}
	if (bDebug) log("Dungeon Door Fix -->");
}

defaultproperties
{
     bEnabled=True
}
