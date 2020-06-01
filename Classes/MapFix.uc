//=============================================================================
// Map tweaking template headers
//=============================================================================
class MapFix extends Actor;

var bool bTweaked;
var config bool bDebug;
var config bool bEnabled;
var config bool bIncludeLAS140Tweaks;

event PreBeginPlay()
{
	super.PreBeginPlay();
}

function BeginPlay()
{
	Super.BeginPlay();
}

defaultproperties
{
     bEnabled=True
     bHidden=True
}
