//=============================================================================
// AdvancedASTeamTrigger (timo@utassault.net)
//=============================================================================
class AdvancedASTeamTrigger extends TeamTrigger;
var() travel int Health;
var() bool bFlashing;
var() bool bDebug;
var	  int DamagePointer;
var	  float TotalDamage;

function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, 
						Vector momentum, name damageType)
{

	local Actor A;
	if (bDebug)
		instigatedBy.Instigator.ClientMessage("Damage:"@Damage);
		
	if ((instigatedBy == None) || (instigatedBy.bIsPlayer && (instigatedBy.PlayerReplicationInfo.Team == Assault(Level.Game).Defender.TeamIndex)) )
		return;
	Health -= Damage;
	
	if (bDebug)
		instigatedBy.Instigator.ClientMessage("Health left:"@Health);
		
	if ( Health < 0 )
	{
		if( Event != '' )
			foreach AllActors( class 'Actor', A, Event )
				A.Trigger( instigatedBy, instigatedBy );

		if( Message != "" )
			// Send a string message to the toucher.
			instigatedBy.Instigator.ClientMessage( Message );

		// Ignore future touches.
		SetCollision(False);
	}
	else
	{	
		TotalDamage += Damage;
		AmbientSound = sound'WarningSound'; 
		if ( bFlashing && ((TimerRate == 0) || (TimerRate - TimerCounter > 0.01 * Health)) )
			SetTimer(FClamp(0.006 * Health,0.2,1.5), true);
	}
}

defaultproperties
{
     Health=100
     bFlashing=True
}
