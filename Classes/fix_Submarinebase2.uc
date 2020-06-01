//===============================================================================================
// Submarinebase][ - timo@utassault.net - '//3iRd(o) pwns with another Mapfix - Dec'2004
//===============================================================================================
class fix_Submarinebase2 extends MapFix config(MapFixesLA11);

var bool bTweaked;
var config bool bDebug;
var config bool bEnabled;
var config bool bTweakSubRoof;

function BeginPlay()
{
	Super.BeginPlay();
	if (!bTweaked)
	{
		bTweaked = True;
		if (bEnabled)
		{
			if (bIncludeLAS140Tweaks)
 				fixSubSpawns();
 		}
 	}
}

function fixSubSpawns()
{
	local PlayerStart P;
	local Trigger T;
	local Mover M;
	local TeamTrigger TT;
	local string S;
	local string SA;
	
	S = Left(Self, InStr(Self, "."));
	if(S~="AS-Submarinebase][") {
		if (bDebug) log("<-- Sub2 PlayerStart fix begin");
		if (bTweakSubRoof)
		{
			foreach AllActors(class'Mover',M)
			{
				SA = Mid(M, InStr(M, ".") + 1);
				if ((SA~="Mover9" || SA~="Mover8"))
				{
					M.StayOpenTime = 6;
					M.InitialState = 'TriggerOpenTimed';
					M.Tag = 'subroof';
					
				}
			}
		}

		if (bIncludeLAS140Tweaks)
		{
			foreach AllActors(class'Trigger',T)
			{
				SA = Mid(T, InStr(T, ".") + 1);
				if (SA~="Trigger3")
				{
					TT = Spawn(class'TeamTrigger',,,T.Location,T.Rotation);
					TT.TriggerType = T.TriggerType;
					TT.ReTriggerDelay = T.ReTriggerDelay;
					TT.RepeatTriggerTime = T.RepeatTriggerTime;
					TT.Event = T.Event;
					TT.SetCollisionSize(T.CollisionRadius,T.CollisionHeight);
					T.Destroy();
				}
			}
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
			if (bDebug) log("    Sub2 PlayerStart fix end -->");
		}
	}
}

function MoveNavigationPoint(PlayerStart P, vector Loc, rotator R)
{
	P.bStatic = false;
	P.SetLocation(Loc);
	P.SetRotation(R);
	P.bStatic = true;
}

defaultproperties
{
     bEnabled=True
}
