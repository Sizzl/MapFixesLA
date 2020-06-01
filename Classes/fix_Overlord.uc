//================================================================================
// OverlordFix - timo@utassault.net
//================================================================================

class fix_Overlord extends MapFix config(MapFixesLA11);

var bool bTweaked;
var() config bool bFixBlackspots;
var() config bool bEnabled;

event PreBeginPlay()
{
	super.PreBeginPlay();
	if (!bTweaked && bEnabled)
	{
		bTweaked=true;
		TweakMaps();
	}
}

function TweakMaps()
{
	local string S;
	local string SA;
	local actor A;
	local TriggeredBlockAll TBA;
	local BlockAll BA;
	local Miniammo MA;

	S = Left(self, InStr(self, "."));
	if (!(S ~= "AS-Overlord" )) return;

	if (S~="AS-Overlord")
	{
		if (bIncludeLAS140Tweaks)
		{
			foreach AllActors( class 'Actor', A )
			{
				SA = Mid(string(A),InStr(string(A),".") + 1);
				if ( (SA ~= "Mover6") || (SA ~= "Mover7") )
	      {
	      	Mover(A).MoverEncroachType = ME_CrushWhenEncroach;
	      }
	      else if ( (SA ~= "PlayerStart25") || (SA ~= "Trigger2") )
	      {
					A.Destroy();
				}
				else if ( SA ~= "TeamTrigger3" )
	      {
	      	A.SetCollisionSize(A.CollisionRadius * 2 / 3,A.CollisionHeight);
				}
				else if ( SA ~= "FortStandard3" )
	      {
					FortStandard(A).bFlashing = False;
	        FortStandard(A).FortName = "Main Gun Control";
	      }
	      else if ( SA ~= "FortStandard4" )
				{
	      	FortStandard(A).FortName = "The Boiler Room";
	        FortStandard(A).DestroyedMessage = "has been breached.";
	      }
	      else if ( SA ~= "FortStandard0" )
	      {
	      	FortStandard(A).FortName = "The Beachhead";
	        FortStandard(A).DestroyedMessage = "has been breached.";
	      }
	      else if ( SA ~= "SniperRifle0" )
	      {
	        MA = Spawn(Class'Miniammo',self,,vect(450,1712,-1744),A.Rotation);
	        MA.RespawnTime = 5.0;
	        //MA.Tag = "LASAMMO";
	        MA = Spawn(Class'Miniammo',self,,vect(235,1761,-1744),A.Rotation);
					MA.RespawnTime = 5.0;
					//MA.Tag = "LASAMMO";
	      }
	      else if ( SA ~= "MortarSpawner0" )
				{
	      	MortarSpawner(A).ShellSpeed = 500.0;
	        MortarSpawner(A).RateOfFire = 8;
	        MortarSpawner(A).ShellDamage = 100;
	        MortarSpawner(A).Deviation = 800;
	      }
	      else 
	      {
	      }
	    }
		}
		if (bFixBlackspots)
		{
			Spawn(Class'RelevancyTrigger',,,vect(-1670,1840,-1765)).SetCollisionSize(180,50.0);
			Spawn(Class'RelevancyTrigger',,,vect(-1480,2070,-1765)).SetCollisionSize(180,50.0);
			Spawn(Class'RelevancyTrigger',,,vect(-1370,1820,-1765)).SetCollisionSize(180,50.0);
		}
		foreach AllActors( class 'BlockAll', BA )
		{
			if (Mid(BA, InStr(BA, ".") + 1) != "BlockAll6")
				BA.SetCollisionSize(450,10000);
		}
	}
}

defaultproperties
{
     bEnabled=True
}
