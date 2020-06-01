//=============================================================================
// TriggeredBlockAll (cratos@utassault.net)
//=============================================================================

class TriggeredBlockAll extends BlockAll;

var bool bDebug;
var bool bInitiallyActive;
var bool newColActors;
var bool newBlockActors;
var bool newBlockPlayers;


function SetMode(bool initColActors, bool initBlockActors, bool initBlockPlayers, bool trigColActors, bool trigBlockActors, bool trigBlockPlayers)
{
    SetCollision(initColActors,initBlockActors,initBlockPlayers);
    newColActors = trigColActors;
    newBlockActors = trigBlockActors;
    newBlockPlayers = trigBlockPlayers;
}

auto state() OtherTriggerToggles
{
	function Trigger( actor Other, pawn EventInstigator )
	{
		bInitiallyActive = !bInitiallyActive;
		if ( bInitiallyActive )
		{
			if (bDebug) log("BTactive"@self.Name@Other@EventInstigator);
			SetCollision(bCollideActors, bBlockActors, bBlockPlayers);
		}
		else
		{
			if (bDebug) log("BTinactive"@self.Name@Other@EventInstigator);
			SetCollision(newColActors,newBlockActors,newBlockPlayers);
		}
		
	}
}

defaultproperties
{
     bInitiallyActive=True
     bStatic=False
}
