//=============================================================================
// ItemRemoval - Removes specified powerups. (timo@utassault.net - 2005)
//=============================================================================

class ItemRemoval extends Mutator
	config;
var() config bool bDisableShieldBelt;
var() config bool bDisableArmour;
var() config bool bDisableThighPads;
var() config bool bDisableBoots;
var() config bool bDisableHealthPickups;
var() config bool bDisableHealthVials;
var() config bool bDisableInvisibility;
var() config bool bDisableMegaHealth;
var() config bool bDisableRedeemer;
var() config bool bDisableScubaGear;
var() config bool bDisableUDamage;

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	if ( 
	(Other.IsA('UT_Shieldbelt') && bDisableShieldBelt) ||
	(Other.IsA('Armor2') && bDisableArmour) ||
	(Other.IsA('ThighPads') && bDisableThighPads) ||
	(Other.IsA('UT_Jumpboots') && bDisableBoots) ||
	(Other.IsA('MedBox') && bDisableHealthPickups) ||
	(Other.IsA('HealthVial') && bDisableHealthVials) ||
	(Other.IsA('UT_invisibility') && bDisableInvisibility) ||
	(Other.IsA('HealthPack') && bDisableMegaHealth) || 
	(Other.IsA('WarHeadLauncher') && bDisableRedeemer) || 
	(Other.IsA('SCUBAGear') && bDisableScubaGear) || 
	(Other.IsA('UDamage') && bDisableUDamage)
	)
		return false;
	else
		return true; 
}

defaultproperties
{
     bDisableShieldBelt=True
     bDisableInvisibility=True
     bDisableMegaHealth=True
     bDisableRedeemer=True
     bDisableUDamage=True
}
