//=============================================================================
// Saqqara - timo@utassault.net - '//3iRd(o) 2020
//  - Removes the music for this map since it crashes fMod.
//=============================================================================
class fix_Saqqara extends MapFix config(MapFixesLA11);
var bool bTweaked;
var() config bool bEnabled;
var() config bool bDebug;
var PlayerPawn Players[128];
var int PlayerSlot;

function PostBeginPlay()
{
	local string S;
	Super.PostBeginPlay();
	if (!bTweaked)
	{
		S = Left(Self, InStr(Self, "."));
		bTweaked = True;
		if (bEnabled && (Left(S,10) ~= "AS-Saqqara"))
		{
			PlayerSlot = 0;
			if (bDebug)
				log("%% Setting timer for Music update...",'MapFixes');
			SetTimer(1.0,true);
 		}
 	}
}

event Timer()
{
	changeAudio();
}

function checkPlayers()
{
	local int i;
	local PlayerPawn PlayersCache[128];
	for (i = 0; i < PlayerSlot; i++)
	{
		PlayersCache[i] = Players[i];
	}
	for (i = 0; i < PlayerSlot; i++)
	{

		if (PlayersCache[i] != None)
		{
			if (NetConnection(PlayersCache[i].Player) == None)
			{
				removePlayer(i);
			}
		}
	}
}

function removePlayer(int iPlayer)
{
	local int i;
	for (i = iPlayer; i < PlayerSlot; i++)
	{
		if (Players[i+1] != None)
		{
			Players[i] = Players[i+1];
		}
	}
	Players[PlayerSlot] = None;
	PlayerSlot--;
}

function changeAudio()
{
	local MusicEvent ME;
	local FortStandard F;
	local bool bNewPlayer;
	local Pawn P;
	local int i;
	
	P = Level.PawnList;
	While ( P != None )
	{
		if ( P.IsA('PlayerPawn') &&	P.PlayerReplicationInfo != None && NetConnection(PlayerPawn(P).Player) != None)
		{
			bNewPlayer = true;
			for (i = 0; i < PlayerSlot; i++)
			{
				if (Players[i]==PlayerPawn(P))
				{
					bNewPlayer = false;
				}
			}
			if (bNewPlayer)
			{
				Players[PlayerSlot] = PlayerPawn(P);
				PlayerSlot++;
				if (bDebug)
					log("%% Unsetting music for: "$PlayerPawn(P).PlayerReplicationInfo.PlayerName,'MapFixes');
				PlayerPawn(P).ClientSetMusic( None, 0, 0, MTRAN_Instant );
			}
		}
		P = P.nextPawn;
	}
	checkPlayers();
}

defaultproperties
{
     bEnabled=True
}
