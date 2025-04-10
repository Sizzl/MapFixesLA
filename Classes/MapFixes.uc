//=============================================================================
// MapFixesLA11.MapFixes mutator - © 2007 (timo@utassault.net)
// Based on the ASPlus Assault Addon © 2004 '//3iRd(o)
// Mutator handling codebits by Dawn - http://wiki.beyondunreal.com/wiki/Dawn
//=============================================================================
class MapFixes extends Mutator config(MapFixes);

var() config bool bMasterEnabled;
var() config bool bMasterDebug;
var() config bool bMasterIncludeLAS140Tweaks;
var() config bool bMasterPopulateAttributes;
var string Version;
var bool Initialized;
var bool PBPInitialized;

function PreBeginPlay()
{
	local Mutator M, Previous, Temp;
  if ( !PBPInitialized )
  {
      PBPInitialized = True;
			for (M = Level.Game.BaseMutator; M != None; M = M.NextMutator)
			{
				if (GetItemName(string(M.class)) == GetItemName(string(Self.class)))
				{
					Previous.NextMutator = M.NextMutator;
					if (M != Self)
						M.Destroy();
				}
				else
					Previous = M;
			}
      Self.NextMutator = Level.Game.BaseMutator.NextMutator;
      Level.Game.BaseMutator.NextMutator = Self; // place it 1st after BaseMutator
  }
	if (!Initialized)
	{
		Initialized = True;
		SaveConfig();
	      	runASP();
	      	if (bMasterEnabled)
	      		fixMaps();
	}
}

function AddMutator(Mutator M)
{
  if (M == Self)
    return;
  super.AddMutator(M);
}

function runASP()
{
	// Some code here.
}

function fixMaps()
{
  	local string S;
  	local MapFix F;
  	log("%% MapFix Mutator v"$Version$" active %% utassault.net 2004-2020 %%",'MapFixes');
	S = Left(Self, InStr(Self, "."));
  	switch ( Caps(S) )
  	{
		case "AS-ASTHENOSPHERE":
			F = Spawn(class'fix_Asthenosphere');
			break;
		case "AS-AUTORIP":
			F = Spawn(class'fix_AutoRIP');
			break;
		case "AS-BALLISTIC":
			F = Spawn(class'fix_Ballistic');
			break;
		case "AS-BRIDGE":
			F = Spawn(class'fix_Bridge');
			break;
		case "AS-COLDERSTEEL":
			F = Spawn(class'fix_Coldersteel');
			break;
		case "AS-DESOLATE][":
			F = Spawn(class'fix_Desolate2');
			break;
		case "AS-GOLGOTHAAL":
			F = Spawn(class'fix_GolgothaAL');
			break;
		case "AS-GOLGOTHA2AL":
			F = Spawn(class'fix_Golgotha2AL');
			break;
		case "AS-GUARDIA":
			F = Spawn(class'fix_Guardia');
			break;
		case "AS-OVERLORD":
			F = Spawn(class'fix_Overlord');
			break;
		case "AS-RIVERBED]L[AL":
			F = Spawn(class'fix_Riverbed3AL');
			break;
		case "AS-ROCKETCOMMANDSE":
			F = Spawn(class'fix_RCSE');
			break;
		case "AS-SIEGE][":
			F = Spawn(class'fix_Siege2');
			break;
		case "AS-SUBMARINEBASE][":
			F = Spawn(class'fix_Submarinebase2');
			break;
		case "THEDUNGEON]L[BETA2":
			F = Spawn(class'fix_TheDungeons3Betas');
			break;
		case "SNOWDUNESAL_PREVIEW":
			F = Spawn(class'fix_SnowdunesALpreview');
			break;
		case "SNOWDUNESAL_PREVIEW2":
			F = Spawn(class'fix_SnowdunesALpreview');
			break;
		case "SNOWDUNESAL_PREVIEW3":
			F = Spawn(class'fix_SnowdunesALpreview');
			break;
		case "AS-THEDUNGEON]L[BETA2_E":
			F = Spawn(class'fix_TheDungeons3Betas');
			break;
		case "AS-DUNGEON]L[ALBETA2":
			F = Spawn(class'fix_TheDungeons3Betas');
			break;
	}
	// Handle all Saqqara maps
	if (Left(S,10)~="AS-Saqqara")
	{
		log("%% Detected Saqqara",'MapFixes');
		F = Spawn(class'fix_Saqqara');
	}
	if (F != None)
	{
		F.SaveConfig();
		if (bMasterPopulateAttributes)
		{
			F.bDebug = bMasterDebug;
			F.bEnabled = bMasterEnabled;
			F.bIncludeLAS140Tweaks = bMasterIncludeLAS140Tweaks;
			F.SaveConfig();
		}
		F.bIncludeLAS140Tweaks = bMasterIncludeLAS140Tweaks;
	}
	if (bMasterPopulateAttributes)
	{
		bMasterPopulateAttributes=false;
		SaveConfig();
	}
}

function Mutate (string MutateString, PlayerPawn Sender)
{
	local int j;
	local int i;
	local pawn P;
	local string Str;
	local string DescStr;
	local MapFix F;
  
	if (bMasterDebug) log("* MapFix Caught Mutate: "$MutateString);
	
	if ( MutateString ~= "mf help" || MutateString ~= "mf")
	{
		Sender.ClientMessage("* MapFixesLA v"$Version$" - Commands:");
		Sender.ClientMessage(" ");
		if (Sender.bAdmin) {
			Sender.ClientMessage(" - mf save -> Save MapFix config");
			Sender.ClientMessage(" - mf debug -> Toggle MapFix Debug output (map restart)");
			Sender.ClientMessage(" ");
			Sender.ClientMessage(" - mf disable -> Disables MapFix Mutator (map restart)");
			Sender.ClientMessage(" - mf enable -> Enables MapFix Mutator (map restart)");
			Sender.ClientMessage(" - mf disablenext -> Disables MapFix tweaks for next map (map restart/switch)");
			Sender.ClientMessage(" - mf enablenext -> Enables MapFix tweaks for next map (map restart/switch)");
		}
	}
  	if (Sender.bAdmin) {
		if (MutateString ~= "mf debug")
		{
		  	if (bMasterDebug)
		  	{
		  		bMasterDebug = False;
		  		bMasterPopulateAttributes = True;
		  		SaveConfig();
		  		Sender.ClientMessage("* MapFix Debug = False (restart map to initiate)");
		  	}
		  	else
		  	{
		  		bMasterDebug = True;
		  		bMasterPopulateAttributes = True;
		  		SaveConfig(); 	
		  		Sender.ClientMessage("* MapFix Debug = True (restart map to initiate)");
		  	}
		}
		if ( MutateString ~= "mf enable")
		{
	  		bMasterEnabled = True;
	  		SaveConfig(); 	
	  		Sender.ClientMessage("* MapFix Enabled (restart map to initiate)");
		}
		if ( MutateString ~= "mf disable")
		{
	  		bMasterEnabled = False;
	  		SaveConfig(); 	
	  		Sender.ClientMessage("* MapFix Disabled (restart map to initiate)");
		}
		if ( MutateString ~= "mf enablenext")
		{
	  		bMasterEnabled = True;
	  		bMasterPopulateAttributes = True;
	  		SaveConfig(); 	
	  		Sender.ClientMessage("* MapFix Enabled (restart map to initiate)");
		}
		if ( MutateString ~= "mf disablenext")
		{
	  		bMasterEnabled = False;
	  		bMasterPopulateAttributes = True;
	  		SaveConfig(); 	
	  		Sender.ClientMessage("* MapFix Disabled (restart map to initiate)");
		}
		if ( MutateString ~= "mf save")
		{
			Sender.ClientMessage("* Saving MapFix config...");
			SaveConfig();
			foreach BasedActors(class 'MapFix',F)
			{
				if (bMasterDebug) log("* MapFix : Saving config for live actor:-"@Left(F, InStr(F, ".")));
				Sender.ClientMessage("  - Saving config for live actor:-"@Left(F, InStr(F, ".")));
				F.SaveConfig();
			}
			Sender.ClientMessage("* Done.");
		}
	}
	
	if ( NextMutator != None )
		NextMutator.Mutate(MutateString, Sender);
}

simulated function Destroyed()
{
    local Mutator M;
    local HUD H;
    
    if ( Level.Game != None ) {
        if ( Level.Game.BaseMutator == Self )
            Level.Game.BaseMutator = NextMutator;
        if ( Level.Game.DamageMutator == Self )
            Level.Game.DamageMutator = NextDamageMutator;
        if ( Level.Game.MessageMutator == Self )
            Level.Game.MessageMutator = NextMessageMutator;
    }
    ForEach AllActors(Class'Engine.HUD', H)
        if ( H.HUDMutator == Self )
            H.HUDMutator = NextHUDMutator;
    ForEach AllActors(Class'Engine.Mutator', M) {
        if ( M.NextMutator == Self )
            M.NextMutator = NextMutator;
        if ( M.NextHUDMutator == Self )
            M.NextHUDMutator = NextHUDMutator;
        if ( M.NextDamageMutator == Self )
            M.NextDamageMutator = NextDamageMutator;
        if ( M.NextMessageMutator == Self )
            M.NextMessageMutator = NextMessageMutator;
    }
}

defaultproperties
{
     bMasterEnabled=True
     Version="1.1a 20201230-1530"
}
