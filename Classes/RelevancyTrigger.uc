//================================================================================
// RelevancyTrigger - cratos@utassault.net
//================================================================================

class RelevancyTrigger extends Trigger;

function Touch (Actor A)
{
  if ( IsRelevant(A) )
  {
    A.bAlwaysRelevant = True;
  }
}

function UnTouch (Actor A)
{
  if ( IsRelevant(A) &&  !A.Class.Default.bAlwaysRelevant )
  {
    A.bAlwaysRelevant = False;
  }
}

defaultproperties
{
}
