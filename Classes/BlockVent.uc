//================================================================================
// BlockVent.
//================================================================================

class BlockVent extends Actor;

event Trigger (Actor Other, Pawn Instigator)
{
  self.Destroy();
}

defaultproperties
{
    bHidden=True
    RemoteRole=0
    CollisionRadius=128.00
    CollisionHeight=10.00
    bCollideActors=True
    bBlockPlayers=True
}
