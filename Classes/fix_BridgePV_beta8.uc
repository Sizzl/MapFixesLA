//=============================================================================
// BridgePV_beta8 - lilfvb@gmail.com - Ulv 2025
//=============================================================================
class fix_BridgePV_beta8 extends MapFix config(MapFixes);

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
            if (bIncludeLAS140Tweaks)
            {
                fixBridgePV_beta8Objects();
            }
        }
    }
}

function fixBridgePV_beta8Objects()
{
    local string S;
    local string SA;
    local BulletBox BB;
    local RifleShell RS;
    local UT_ShieldBelt SB;
    local Armor2 A2;
    local HealthPack HP;
    local Vector V;
    local Rotator R;

    S = Left(Self, InStr(Self, "."));
    if(S~="AS-BridgePV_beta8")
    {
        foreach AllActors(class'BulletBox', BB)
        {
            SA = Mid(string(BB), InStr(string(BB), ".") + 1);
            if ( (SA == "BulletBox0") || (SA == "BulletBox2") || (SA == "BulletBox3") || (SA == "BulletBox4") || (SA == "BulletBox11") )
            {
                V = BB.Location;
                R = BB.Rotation;
                BB.Destroy();
                RS = Spawn(class'RifleShell',,, V, R);
            }
        }

        // Replace the belt with armor in defender spawn
        foreach AllActors(class'UT_ShieldBelt', SB)
        {
            SA = Mid(string(SB), InStr(string(SB), ".") + 1);
            if (SA == "ut_shieldbelt0")
            {
                V = SB.Location;
                R = SB.Rotation;
                SB.Destroy();
                A2 = Spawn(class'Armor2',,, V, R);
            }
        }

        // Add a Keg in the box in attacker spawn
        V.X = -3120.438721;
        V.Y = 581.074585;
        V.Z = 792.103943;
        R.Pitch = 0;
        R.Roll = 0;
        R.Yaw = 0;
        HP = Spawn(class'HealthPack',,, V, R);

        // Add a RifleShell near the Sniper at Final exit
        V.X = -2507.945801;
        V.Y = -1440.486694;
        V.Z = 1462.380005;
        R.Pitch = 0;
        R.Roll = 0;
        R.Yaw = 0;
        RS = Spawn(class'RifleShell',,, V, R);

        // Add a RocketLauncher near sniper and flak at the underwater tele exit
        V.X = 295.726440;
        V.Y = -448.705444;
        V.Z = -1373.900024;
        R.Pitch = 0;
        R.Roll = 0;
        R.Yaw = 0;
        Spawn(class'UT_EightBall',,, V, R);
    }
}

defaultproperties
{
     bEnabled=True
     bHidden=True
}