//=============================================================================
// zpASHackFix (timo@utassault.net) '//3iRd(o) 2004
//=============================================================================
class zzzpASHackFix extends Actor config(MapFixes);
var() config bool bEnabled;
var() config bool bDebug;

function PostBeginPlay()
{
	Super.PostBeginPlay();
 	fixForts();
}

function fixForts()
{
  	local FortStandard F;
	local AdvancedASTeamTrigger T;
	local string S;
	local string M;
	local string SA;

	if (bEnabled)
	{
		
		log("--------|ZPFix Active|--------");
		M = Left(Self, InStr(Self, "."));
		if (bDebug) log("--------|Debug Mode: ON|--------");
		foreach AllActors( class 'FortStandard', F)
		{
			S = Mid(F, InStr(F, ".") + 1);;
			if (!F.bTriggerOnly)
			{
				SA = string(F.Tag)$"_zp";
				T = Spawn(class'AdvancedASTeamTrigger',,, F.location, F.Rotation);
				T.SetCollisionSize(F.CollisionHeight,F.CollisionRadius);
				if (bDebug) log(M@"-"@S);
				
				if ((M~="AS-Submarinebase][") && (S~="FortStandard0")) // Sub][ vent fix
				{
					F.Tag = 'zpfs0';
					T.Event = 'zpfs0';	
				}
				
				if (F.Tag != '')
				{
					T.Event = F.Tag;
				}
				else if (F.Event != '')
				{
					F.Tag = F.Event;
					T.Tag = F.Tag;
				}
				else
				{
					F.Tag = 'temp001';
					T.Event = 'temp001';	
				}
				T.Health = F.Health;
				T.bFlashing = F.bFlashing;
				if (bDebug) T.bDebug = true;
				T.TriggerType = TT_Shoot;
				T.bProjTarget = true;
				F.SetCollision(false);
				F.bProjTarget = false;

			}
		}
	if (bDebug) log("--------|ZPFix Finished|--------");
	}	
}

defaultproperties
{
     bEnabled=True
}