//=============================================================================
// Siege][ - timo@utassault.net - '//3iRd(o) 2004
//=============================================================================
class fix_Siege2 extends MapFix config(MapFixes);

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
 				changeObjs();
 		}
 	}
}

function changeObjs()
{
	local barrel B;
	local WoodenBox W;
  	local string S;
	S = Left(Self, InStr(Self, "."));
	
	if ( S ~= "AS-Siege][") {
		if (bEnabled)
		{
			foreach AllActors( class 'barrel', B)
			{
				W = Spawn(class'WoodenBox',,, B.location, B.Rotation);
				W.Mesh = B.Mesh;
				W.Skin = B.Skin;
				W.Health = B.Health;
				W.FragChunks = 0;
				W.Fragsize = 0;
				W.SetCollisionSize(B.CollisionHeight,B.CollisionRadius);
				W.EffectWhenDestroyed = Class'UnrealShare.ParticleBurst2';
				B.Destroy();
			}
		}
	}
}

defaultproperties
{
     bEnabled=True
}
