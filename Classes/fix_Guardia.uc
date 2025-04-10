//===============================================================================================
// Guardia fixes - timo@utassault.net - '//3iRd(o) pwns with another Mapfix - Jan'2005
//===============================================================================================
class fix_Guardia extends MapFix config(MapFixes);

var bool bTweaked;
var config bool bDebug;
var config bool bEnabled;
var config bool bKillCannon1;
var config bool bKillCannon2;

function BeginPlay()
{
	local string S;
	Super.BeginPlay();
	if (!bTweaked)
	{
		bTweaked = True;
		S = Left(Self, InStr(Self, "."));
		if(S~="AS-Guardia" && bEnabled) {
			tweakCannons();
		}
	}
}

function tweakCannons()
{
	local TeamCannon TC;
	local string SA;


	if (bDebug) log("<-- Guardia fix begin");

	foreach AllActors(class'TeamCannon', TC)
	{
		SA = Mid(TC, InStr(TC, ".") + 1);
	        if (SA~="TeamCannon0" && bKillCannon1) { TC.Destroy(); }
	        if (SA~="TeamCannon1" && bKillCannon2) { TC.Destroy(); }
	}
	if (bDebug) log("    Guardia fix end -->");

}

defaultproperties
{
     bEnabled=True
}
