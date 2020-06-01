//=============================================================================
// Golgotha][AL - timo@utassault.net - '//3iRd(o)
//=============================================================================
class fix_Golgotha2AL extends MapFix config(MapFixesLA11); // Info

var config bool bEnabled;
var config bool bDebug;
var config bool bKillTriggers;

var class ffC;
var actor ffA;
var string ffixString;

function PostBeginPlay()
{
	if (bEnabled)
	{
		if (bDebug) Log("FrameFix is enabled");
			
		ffixString = Left(Self, InStr(Self, "."));
		if(ffixString~="AS-Golgotha][AL") {
			spawnMyM(vect(-4217.195801,3266.204590,-1162.392578),60,10);
			spawnMyM(vect(-4253.232910,3308.805908,-1162.392578),60,10);
			spawnMyM(vect(-4253.098145,3200.064453,-1162.392578),60,10);
			spawnMyM(vect(-4274.643066,3132.049805,-1162.392578),60,10);
			spawnMyM(vect(-4284.736816,3052.366943,-1162.392578),60,10);
	
			ffC = class<Actor>(DynamicLoadObject("mut_Gol2FFixMootie",class'Class'));
			if (ffC == None) {
				if (bDebug) Log("Failed to load FrameFix");
			}
			else
			{
				ffA = Level.Spawn(class<Actor>(ffC));
				if((ffA!=None) && ffA.IsA('Mutator') && (Mutator(ffA)!=None)) {
					mut_Gol2FFixMootie(ffA).bDebug = bDebug;
					mut_Gol2FFixMootie(ffA).bEnabled = bEnabled;
					Level.Game.BaseMutator.AddMutator(Mutator(ffA));
					if (bDebug) Log("FrameFix loaded");
				}
			}
		}
	}
   
}

function spawnMyM(vector MyMCoords, float colWidth, float colHeight)
{
	local TriggeredBlockAll BM;
	
	BM = Spawn(class'TriggeredBlockAll',,, MyMCoords);
	if (BM != None)
	{
		BM.SetCollisionSize(colWidth,colHeight);
		BM.SetMode(true,true,true,false,false,false);
		BM.bDebug = bDebug;
	}	
	
}

defaultproperties
{
	bEnabled=True
}
