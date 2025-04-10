//================================================================================
// RocketCommandSE - timo@utassault.net - 2004 '//3iRd(o)
//================================================================================
class fix_RCSE extends MapFix config(MapFixes);

var bool bTweaked;
var() config bool bEnabled;
var() config bool bDebug;

function BeginPlay()
{
	Super.BeginPlay();
	if (!bTweaked)
	{
		bTweaked = True;
		if (bEnabled)
		{
 			fixEverything();
 		}
 	}
}

function fixEverything()
{
  	local TriggeredBlockAll BT;
  	local FortStandard F;
  	local ShockRifle S;
  	local PulseGun P;
  	local Mover M;
  	local TeamTrigger T;
  	local BulletBox BBAmmo;

	if ( Level.Title == "Rocket Command [Second Edition]" ) {
		
		foreach AllActors( class 'FortStandard', F )
		{
			if( F.Name == 'FortStandard9' ) {
			 	F.SetLocation(vect(-13110.313477,-2717.143555,106.599998));
		 	}
		 	else if( F.Name == 'FortStandard17' ) {
			 	F.SetLocation(vect(-5616.643066,-4362.471191,-590.899170));
		 	}
		 	else if( F.Name == 'FortStandard25' ) {
			 	F.SetLocation(vect(-14446.114258,1052.596680,100.599998));
		 	}
		 	else if( F.Name == 'FortStandard26' ) {
			 	F.SetLocation(vect(-10915.303711,-2594.994629,534.496704));
		 		F.SetCollisionSize(30,30);
		 	}
		}
		foreach AllActors( class 'ShockRifle',S )
		{
			if ( S.Name == 'ShockRifle4' ) {
				S.Destroy();
			}
		}
		foreach AllActors( class 'BulletBox',BBAmmo )
		{
			if ( BBAmmo.Name == 'BulletBox5' ) {
				BBAmmo.SetLocation(vect(8434.818359,5831.952148,36.099785));
			}
			else if ( BBAmmo.Name == 'BulletBox6' ) {
				BBAmmo.SetLocation(vect(8478.554688,5734.411133,35.099937));
			}
		}
		
		P = Spawn(class'PulseGun',,, vect(-4130.000000,-1820.000000,-617.000000));
		
		foreach AllActors( class 'Mover', M )
		{
			if ( M.Name == 'Mover66' ) {
				M.MoveTime = 0.50;
				M.bDamageTriggered = true;
				M.StayOpenTime = 6;
				
			}
			else if ( M.Name == 'Mover53' ) {
				M.MoveTime = 0.50;
				M.bDamageTriggered = true;
				M.StayOpenTime = 6;
				
			}
		}

		foreach AllActors( class 'TeamTrigger',T )
		{
			if ( T.Name == 'TeamTrigger2' ) {
				T.SetCollisionSize(30,20);
			}
		}


		BT = Spawn(class'TriggeredBlockAll',,, vect(-8310.000000,-500.000000,-550.000000));
		BT.SetCollisionSize(55,150);
		BT.SetMode(true,true,true,false,false,false);
		BT.bDebug = bDebug;
		BT.Tag = 'SideDoorDisp';

		BT = Spawn(class'TriggeredBlockAll',,, vect(-8444.000000,-430.000000,-520.000000));
		BT.SetCollisionSize(70,150);
		BT.SetMode(true,true,true,false,false,false);
		BT.bDebug = bDebug;
		BT.Tag = 'SideDoorDisp';
		BT = Spawn(class'TriggeredBlockAll',,, vect(-8416.000000,-430.000000,-520.000000));
		BT.SetCollisionSize(70,150);
		BT.SetMode(true,true,true,false,false,false);
		BT.bDebug = bDebug;
		BT.Tag = 'SideDoorDisp';
		BT = Spawn(class'TriggeredBlockAll',,, vect(-8388.000000,-430.000000,-520.000000));
		BT.SetCollisionSize(70,150);
		BT.SetMode(true,true,true,false,false,false);
		BT.bDebug = bDebug;
		BT.Tag = 'SideDoorDisp';
	}
}

defaultproperties
{
     bEnabled=True
}
