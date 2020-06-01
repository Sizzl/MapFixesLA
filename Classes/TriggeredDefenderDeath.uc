//-----------------------------------------------------------
// TriggeredDefenderDeath
//-----------------------------------------------------------
class TriggeredDefenderDeath extends TriggeredDeath;
var() string MessageData;

auto state Enabled
{
	function Touch(Actor Other)
	{
		 if (Other.IsA('PlayerPawn') && PlayerPawn(Other).PlayerReplicationInfo.Team == Assault(Level.Game).Defender.TeamIndex)
		 {
		 	if (Len(MessageData)>0)
		 		PlayerPawn(Other).ClientMessage(MessageData);
			super.Touch(Other);
		 }
	}

}

defaultproperties
{
     MessageData="Don't enter the attackers spawnarea!"
}
