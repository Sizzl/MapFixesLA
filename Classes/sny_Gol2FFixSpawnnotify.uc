//=============================================================================
// Golgotha][AL - timo@utassault.net - '//3iRd(o)
//=============================================================================
class sny_Gol2FFixSpawnnotify extends SpawnNotify;

var bool bDebug;
var bool Initialized;

function PreBeginPlay()
{

  bAlwaysRelevant = true;
}

simulated function PostBeginPlay()
{
	local Actor A;

	if (Initialized)
		return;
	Initialized = True;
	ForEach AllActors(class'Actor', A)
	{
		if ( A.IsA('Light') && A.Name=='Light420')
		{
			if (bDebug)
				log("Rogue light found: "@A.Name);
			A.bDynamicLight = false;
			A.LightType = LT_None;
			A.bStatic = false;
			A.bHidden = true;
			A.bNoDelete = false;
			log("Rogue light destoryed: "@A.Destroy());
		}
		if ( A.IsA('TriggerLight'))
		{
			if (bDebug)
				log("Rogue triggerlight found: "@A.Name);
			A.bDynamicLight = false;
			A.LightType = LT_None;
			A.bStatic = false;
			A.bHidden = true;
			A.bNoDelete = false;
			log("Rogue triggerlight destoryed: "@A.Destroy());

		}
	}
	Super.PostBeginPlay();
}

defaultproperties
{
     bDebug=True
}
