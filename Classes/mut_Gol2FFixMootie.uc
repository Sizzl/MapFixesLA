//=============================================================================
// Golgotha][AL - timo@utassault.net - '//3iRd(o)
//=============================================================================
class mut_Gol2FFixMootie extends Mutator;

var bool Initialized;
var bool bDebug;
var bool bEnabled;
var sny_Gol2FFixSpawnnotify ffix;

event PreBeginPlay()
{
	if ( !Initialized )
	{
		if (bEnabled)
		{
			ffix = Spawn(class'sny_Gol2FFixSpawnnotify');
			ffix.bDebug = bDebug;
		}
		Initialized = True;
	}
}

function Mutate(string MutateString, PlayerPawn Sender)
{
	Super.Mutate(MutateString, Sender);
}

defaultproperties
{
     bEnabled=True
}
