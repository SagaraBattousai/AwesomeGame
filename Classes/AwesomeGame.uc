class AwesomeGame extends UTDeathmatch;

var int EnemiesLeft;
var array<AwesomeEnemySpawner> EnemySpawners;
var float MinSpawnerDistance, MaxSpawnerDistance;
var bool bFirstEnemySpawned;

simulated function PostBeginPlay()
{
    local AwesomeEnemySpawner ES;

    super.PostBeginPlay();

    GoalScore = EnemiesLeft;

    foreach DynamicActors(class'AwesomeEnemySpawner',ES)
        EnemySpawners[EnemySpawners.length] = ES;

    `log("Number of Spawners:" @ EnemySpawners.length);
    SetTimer(5.0, false, 'ActivateSpawners');

}

function ScoreObjective(PlayerReplicationInfo Scorer, Int Score)
{
    local int i;

    EnemiesLeft--;
    super.ScoreObjective(Scorer, Score);

    if(EnemiesLeft == 0)
    {
        for(i = 0; i <EnemySpawners.length; i++)
            EnemySpawners[i].FreezeEnemy();
        ClearTimer('ActivateSpawners');
    }
}

function ActivateSpawners()
{
    local array <AwesomeEnemySpawner> InRangeSpawners;
    local int i;
    local AwesomePlayerController PC;

    bFirstEnemySpawned = True;
    foreach LocalPlayerControllers(class'AwesomePlayerController', PC)
        break;
    
    if(PC.Pawn == none)
    {
        SetTimer(1.0, false, 'ActivateSpawners');
        return;
    }
    
    for(i = 0; i < EnemySpawners.length; i++)
    {
        if(VSize(PC.Pawn.Location - EnemySpawners[i].Location) > MinSpawnerDistance &&
            VSize(PC.Pawn.Location - EnemySpawners[i].Location) < MaxSpawnerDistance)
            {
                if(EnemySpawners[i].CanSpawnEnemy())
                    InRangeSpawners[InRangeSpawners.length] = EnemySpawners[i];
            }
    }
    if(InRangeSpawners.length == 0)
    {
        `log("No Enemy Spawners Within Range!");
        SetTimer(1.0, false, 'ActivateSpawners');
        return;
    }
    
    InRangeSpawners[Rand(InRangeSpawners.length)].SpawnEnemy();
    SetTimer(1.0 + FRand() * 3.0, false, 'ActivateSpawners');
}

defaultproperties
{
    MinSpawnerDistance=1700.0
    MaxSpawnerDistance=3000.0
    EnemiesLeft=10
    PlayerControllerClass=class'AwesomeGame.AwesomePlayerController'
    DefaultPawnClass=class'AwesomeGame.AwesomePawn'
    bScoreDeaths=false
    DefaultInventory(0)=None
}