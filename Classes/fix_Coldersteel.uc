//-----------------------------------------------------------
// Coldersteel fixes - timo@utassault.net - '//3iRd(o) pwns with another Mapfix - Jan'2005
// Additional Coldersteel Fixes - May 2005 - (cratos@utassault.net)
//-----------------------------------------------------------
class fix_ColderSteel extends MapFix config(MapFixes);

var bool bTweaked;
var config bool bDebug;
var config bool bEnabled;
var config bool bUseCratosFixes;
var config bool bUseTimoFixes;

event PreBeginPlay()
{
	super.PreBeginPlay();
	if (!bTweaked)
	{
		bTweaked=true;
		if (bEnabled)
		{
	  		if (bUseCratosFixes && bIncludeLAS140Tweaks);
			  	TweakMaps();
	  		if (bUseTimoFixes)
			  	fixZuhSteelMahp();
		}
	}
}

function TweakMaps()
{
	local string S, SA;
	local actor A;
	local SpecialEvent SE;
	local TeamTrigger TT;


	S = Left(self, InStr(self, "."));
	if (!(S ~= "AS-Coldersteel" )) return;

	if (S~="AS-Coldersteel") {

		// Trigered Defender Death
		Spawn(class'TriggeredDefenderDeath',,,vect(-16069,-6966,-1213)).SetCollisionSize(250,1000);
		Spawn(class'TriggeredDefenderDeath',,,vect(-16069,-9399,-1213)).SetCollisionSize(250,1000);

	   // Rockets at start
	   Spawn(class'UT_Eightball',,,vect(-16080.000000,-6740.000000,-1250.000000),rot(0,624,0)).bRotatingPickup=false;
	   Spawn(class'RocketPack',,,vect(-16290.000000,-6720.000000,-1250.000000),rot(0,-1000,0));
	   Spawn(class'RocketPack',,,vect(-16344.000000,-6720.000000,-1250.000000),rot(0,-1000,0));
	   Spawn(class'UT_Eightball',,,vect(-16085.000000,-9660.000000,-1250.000000),rot(0,300,0)).bRotatingPickup=false;
	   Spawn(class'RocketPack',,,vect(-16350.000000,-9640.000000,-1250.000000),rot(0,-500,0));
	   Spawn(class'RocketPack',,,vect(-16295.000000,-9640.000000,-1250.000000),rot(0,-500,0));
	   // Weapons after Laserfield
	   Spawn(class'BotPack.SniperRifle',,,vect(-10450,-8650,-2080),rot(0,624,0)).bRotatingPickup=false;;
	   Spawn(class'BotPack.BulletBox',,,vect(-10350,-8650,-2060),rot(0,624,0)).bRotatingPickup=false;;
	   Spawn(class'BotPack.BulletBox',,,vect(-10550,-8650,-2130),rot(0,624,0)).bRotatingPickup=false;;

	   // Rockets in Snowfield for attackers to launch
	   Spawn(class'UT_Eightball',,,vect(-850.000000,-620.000000,-990.000000),rot(0,624,0)).bRotatingPickup=false;
	   Spawn(class'RocketPack',,,vect(-840,-665,-990),rot(0,0,0));
	   Spawn(class'RocketPack',,,vect(-840,-570,-990),rot(0,0,0));
	   // ThighPads at Snowfield
	   Spawn(class'ThighPads',,,vect(-1310.788208,40.000000,-964.191406)).RespawnTime = 20;
	   // Spawn(class'UT_ShieldBelt',,,vect(-1020.046875,80.000000,-487.901367),rot(0,21300,0));

	   // HeadQuater
	   Spawn(class'Minigun2',,,vect(-4510,-5600,-1250),rot(16500,0,0)).bRotatingPickup=false;
	   //Spawn(class'Miniammo',,,vect(-4520,-5572,-1270),rot(0,0,0));

	   // Add Message on Roof
	   SE = Spawn(class'SpecialEvent');
	   SE.bBroadcast = true;
	   SE.Message = "Attackers are on the roof";
	   SE.Tag = 'RoofWarning';             // 4100-7100/ -500-1200
	   TT = Spawn(class'TeamTrigger',,,vect(5550,350,-110));
	   TT.SetCollisionSize(1800,120);
	   TT.Team = 0;
	   TT.RepeatTriggerTime = 5;
	   TT.event = 'RoofWarning';

	   log("AS-Coldersteel fixed!",'ColdersteelFix');
	}

	foreach AllActors(class'Actor', A)
	{
	   //////////////AS-Coldersteel //////////////
	   if (S ~= "AS-Coldersteel" )
	   {
			SA = Mid(A, InStr(A, ".") + 1);


			// Mover fix
			if (SA ~= "Mover48" || SA ~= "Mover52")
			{
				Mover(A).MoverEncroachType = ME_IgnoreWhenEncroach;
			}

			// Replace Bio with Sniper (In Headquaters)
			/*
			if (SA ~= "ut_biorifle0")
			{
			 	Level.Game.BaseMutator.ReplaceWith(A, "BotPack.SniperRifle");
				//Pickup(A).bRotatingPickup=false;
				A.Destroy();
			}
			if (SA ~= "bioammo0" || SA ~= "bioammo1" || SA ~= "bioammo2")
			{
			 	Level.Game.BaseMutator.ReplaceWith(A, "BotPack.BulletBox");
				A.Destroy();
			}
			*/

			// Fix Attackers Spawn after Laserfield
			if (SA ~= "PlayerStart5") MoveNavigationPoint(PlayerStart(A),vect(-10794,-8140,-2142),rot(0,3008,0));
			if (SA ~= "PlayerStart67") MoveNavigationPoint(PlayerStart(A),vect(-10794,-8451,-2142),rot(0,3008,0));
			// Fix Defender Spawn after Laserfield
 			if (SA ~= "PlayerStart1") MoveNavigationPoint(PlayerStart(A),vect(-7700,-9030,-1624),rot(0,179720,0));
			if (SA ~= "PlayerStart66") MoveNavigationPoint(PlayerStart(A),vect(-7866,-9530,-1495),rot(0,-39052,0));
 			if (SA ~= "PlayerStart11") MoveNavigationPoint(PlayerStart(A),vect(-7766,-9530,-1495),rot(0,-39052,0));
 			if (SA ~= "PlayerStart12") MoveNavigationPoint(PlayerStart(A),vect(-7666,-9530,-1495),rot(0,-39052,0));
 		 	if (SA ~= "PlayerStart13") MoveNavigationPoint(PlayerStart(A),vect(-7566,-9530,-1495),rot(0,-39052,0));

		 	if (SA ~= "PlayerStart21") MoveNavigationPoint(PlayerStart(A),vect(-7650,-8281,-1495),rot(0,97484,0));
			if (SA ~= "PlayerStart3") MoveNavigationPoint(PlayerStart(A),vect(-7650,-8381,-1495),rot(0,97484,0));
  			if (SA ~= "PlayerStart65") MoveNavigationPoint(PlayerStart(A),vect(-7650,-8181,-1495),rot(0,97484,0));
			// Move Green
			// if (SA ~= "PAmmo4") A.SetLocation(vect(-10289,-7719,-2025));
			// if (SA ~= "PulseGun2") { A.SetLocation(vect(-10369,-7719,-2048)); Pickup(A).bRotatingPickup = false; }
			// if (SA ~= "PAmmo5") A.SetLocation(vect(-10440,-7719,-2080));

  			// Fix Defenders Playerstart Spawns as Snowfield
			// if (SA ~= "PlayerStart14") MoveNavigationPoint(PlayerStart(A),vect(-2557.152344,-1294.815918,-941.897888),rot(0,-16036,0));
			if (SA ~= "PlayerStart47") MoveNavigationPoint(PlayerStart(A),vect(-1115.233887,291.258667,-957.908630),rot(0,-30812,0));
			if (SA ~= "PlayerStart52") MoveNavigationPoint(PlayerStart(A),vect(-1145.233887,391.258667,-957.908630),rot(0,-30812,0));
			if (SA ~= "PlayerStart48") MoveNavigationPoint(PlayerStart(A),vect(-1015.233887,300.000000,-957.908630),rot(0,101348,0));
			if (SA ~= "PlayerStart38") MoveNavigationPoint(PlayerStart(A),vect(-1015.233887,391.258667,-957.908630),rot(0,101348,0));
			if (SA ~= "PlayerStart30") MoveNavigationPoint(PlayerStart(A),vect(-800,410,-957.919800),rot(0,101348,0));
			if (SA ~= "PlayerStart51") MoveNavigationPoint(PlayerStart(A),vect(-900,410,-957.919800),rot(0,101348,0));
			if (SA ~= "PlayerStart49") MoveNavigationPoint(PlayerStart(A),vect(-870,480,-957.919800),rot(0,101348,0));
			if (SA ~= "PlayerStart50") MoveNavigationPoint(PlayerStart(A),vect(-870,340,-957.919800),rot(0,101348,0));

			// Fix Defenders Playerstart Spawns at last Objective
			// right path
			if (SA ~= "PlayerStart56") MoveNavigationPoint(PlayerStart(A),vect(6540.000000,-800.000000,-919.000000),rot(0,23776,0));
			if (SA ~= "PlayerStart62") MoveNavigationPoint(PlayerStart(A),vect(6630.000000,-890.000000,-919.000000),rot(0,23776,0));
			// left path
			if (SA ~= "PlayerStart69") MoveNavigationPoint(PlayerStart(A),vect(6748.633789,1775.126709,-919.900208),rot(0,-25796,0));
			if (SA ~= "PlayerStart68") MoveNavigationPoint(PlayerStart(A),vect(6647.633789,1675.126709,-919.900208),rot(0,-25796,0));
			if (SA ~= "PlayerStart64") MoveNavigationPoint(PlayerStart(A),vect(6517.633789,1555.126709,-919.900208),rot(0,-25796,0));

			// Remove udamage, inis, cannons and ammo in last room
			if (A.IsA('TeamCannon')) A.Destroy();
			if (A.IsA('MinigunCannon')) A.Destroy();
			if (A.IsA('UDamage') || A.IsA('UT_invisibility')) A.Destroy();
			if ((SA ~= "Rocketpack23") || (SA ~= "Rocketpack24")) A.Destroy();
			if ((SA ~= "Bladehopper8") || (SA ~= "Bladehopper9")) A.Destroy();
			if ((SA ~= "Miniammo5") || (SA ~= "Miniammo17")) A.Destroy();
			if ((SA ~= "Flakammo6") ||(SA ~= "Flakammo8")) Flakammo(A).RespawnTime = 45;
			if ((SA ~= "Bladehopper11") || (SA ~= "Bladehopper13")) A.Destroy();
			if ((SA ~= "Rocketpack25") || (SA ~= "Rocketpack26") || (SA ~= "Rocketpack27")|| (SA ~= "Rocketpack28")) A.Destroy();

				// Headquater before snowfield
			if ((SA ~= "ShockCore4") || (SA ~= "ShockCore6")) A.Destroy();
			if (SA ~= "ShockRifle3") A.SetLocation(vect(-4602,-5250,-1271));
			if (SA ~= "ShockRifle3") A.SetRotation(rot(0,0,0));
			if (SA ~= "ShockCore9") A.SetLocation(vect(-4602,-5290,-1259));
			if (SA ~= "ShockCore7") A.SetLocation(vect(-4602,-5210,-1259));
			//if (SA ~= "Armor4") A.SetLocation(vect(-4554.139160,-4855,-1249.909424));
			if (SA ~= "Armor4") A.SetLocation(vect(-4554,-4520,-1249.909424));
			if (SA ~= "TarydiumBarrel") A.Destroy();
			if ((SA ~= "FlakAmmo6") || (SA ~= "FlakAmmo8")) A.Destroy();


			// Rocketpack after Laserfield
			if ((SA ~= "Rocketpack5") || (SA ~= "Rocketpack4")) A.Destroy();


			// Fix dispatchers
			if (SA~="Dispatcher0")
			{
				Dispatcher(A).OutEvents[0] = 'attackerStart2';
				Dispatcher(A).OutEvents[1] = 'attackerStart1';
				Dispatcher(A).OutEvents[2] = 'defenderStart2';
				Dispatcher(A).OutEvents[3] = 'defenderStart1b';
				Dispatcher(A).OutEvents[4] = 'defenderStart1';
			}
			if (SA~="Dispatcher1")
			{
				Dispatcher(A).OutEvents[0] = 'attackerStart4';
				Dispatcher(A).OutEvents[1] = 'attackerStart3';
				Dispatcher(A).OutEvents[2] = 'defenderStart4';
				Dispatcher(A).OutEvents[3] = 'defenderStart3';
			}
			if (SA~="Dispatcher2")
			{
				Dispatcher(A).OutEvents[0] = 'attackerStart3';
				Dispatcher(A).OutEvents[1] = 'attackerStart2';
				Dispatcher(A).OutEvents[2] = 'defenderStart3';
				Dispatcher(A).OutEvents[3] = 'defenderStart2';
			}
			if (SA~="Dispatcher3")
			{
				Dispatcher(A).OutEvents[0] = 'attackerStart5';
				Dispatcher(A).OutEvents[1] = 'attackerStart4';
				Dispatcher(A).OutEvents[2] = 'defenderStart5';
				Dispatcher(A).OutEvents[3] = 'defenderStart4';
			}
			if (SA~="Dispatcher4")
			{
				Dispatcher(A).OutEvents[0] = 'defenderStart1b';
				Dispatcher(A).OutEvents[1] = 'defenderStart1a';
			}


			if (SA ~= "FortStandard0")
			{
					FortStandard(A).FortName = "Laser fence";
					FortStandard(A).DestroyedMessage = "deactivated";
			}
			if (SA ~= "FortStandard1")
			{
					FortStandard(A).FortName = "Hanger door release 1";
					FortStandard(A).DestroyedMessage = "engaged";
			}
			if (SA ~= "FortStandard2")
			{
					FortStandard(A).FortName = "Hanger door release 2";
					FortStandard(A).DestroyedMessage = "engaged";
			}
			if (SA ~= "FortStandard3")
			{
					FortStandard(A).FortName = "The crew quarters";
					FortStandard(A).DestroyedMessage = "are now accessable";
			}
			if (SA ~= "FortStandard9")
			{
					FortStandard(A).FortName = "The Snowfield";
					FortStandard(A).DestroyedMessage = "has been reached";
			}
			if (SA ~= "FortStandard12")
			{
					//FortStandard(A).FortName = "Generators";
               FortStandard(A).SetLocation(vect(9000,400,-600));
			}
	   }
	}
}
//************************************************************************************************
function fixZuhSteelMahp()
{
	local PlayerStart P;
	local TeamCannon TC;
	local UT_Invisibility Inv;
	local ThighPads TP;
	local MinigunCannon TCM;
	local Armor2 PA;

	local string S;
	local string SA;

	S = Left(Self, InStr(Self, "."));
	if(S~="AS-Coldersteel") {
		if (bDebug) log("<-- Coldersteel fix begin");

		foreach AllActors(class'TeamCannon', TC)
		{
			SA = Mid(TC, InStr(TC, ".") + 1);
		        if (SA~="TeamCannon2")
                	{
                		TP = Spawn(class'ThighPads',,'MofoTeamCannon',vect(-11290.456055,-8191.975098,-1500.000000),rot(0,-17580,-15740));
                		TC.Destroy();
                	}
		        else
		        {
   	               		TC.Destroy();
                	}
		}
		foreach AllActors(class'UT_Invisibility',Inv)
		{
		        Inv.Destroy();
		}
		foreach AllActors(class'MinigunCannon',TCM)
		{
			SA = Mid(P, InStr(TCM, ".") + 1);
		        if (SA~="MinigunCannon3")
		        {
                        	PA = Spawn(class'Armor2',,'MofoTeamCannon',vect(-8870.461914,-9687.212891,-1424.000000),rot(0,-4372,8664));
          		        TCM.Destroy();
		        }
		        else
		        {
          		        TCM.Destroy();
		        }
		}


	        if (1==2)
	        {
			foreach AllActors(class'PlayerStart', P)
			{
				SA = Mid(P, InStr(P, ".") + 1);
				if (SA~="PlayerStart21")
				{
					MoveNavigationPoint(P,vect(13350,-130,555),rot(0,32720,0));
					P.Tag='def3';
					if (bDebug) log("New (moved) playerstart: "$P.Name$" - "$P.Tag$" @ "$P.location);
				}
				else if (SA~="PlayerStart23")
				{
					MoveNavigationPoint(P,vect(11140,1160,480),rot(0,32720,0));
					P.Tag='def3';
					if (bDebug) log("New (moved) playerstart: "$P.Name$" - "$P.Tag$" @ "$P.location);
				}
				else if (SA~="PlayerStart29")
				{
					MoveNavigationPoint(P,vect(11200,1160,480),rot(0,32720,0));
					P.Tag='def3';
					if (bDebug) log("New (moved) playerstart: "$P.Name$" - "$P.Tag$" @ "$P.location);
				}
				else if (SA~="PlayerStart30")
				{
					MoveNavigationPoint(P,vect(14350,-130,555),rot(0,32720,0));
					P.Tag='def3';
					if (bDebug) log("New (moved) playerstart: "$P.Name$" - "$P.Tag$" @ "$P.location);
				}
				else if (SA~="PlayerStart6")
				{
					if (bDebug) log(P.Name$" - was tagged as "$P.Tag);
					P.Tag='def4';
					if (bDebug) log(P.Name$" - now tagged as "$P.Tag);
				}
			}
		}
		if (bDebug) log("    ColderSteel fix end -->");
	}
}

//************************************************************************************************
function MoveNavigationPoint(PlayerStart A, vector L, rotator R)
{
	A.bStatic = false;
	A.SetLocation(L);
	A.SetRotation(R);
	A.bStatic = true;
}

defaultproperties
{
     bEnabled=True
     bUseCratosFixes=True
}
