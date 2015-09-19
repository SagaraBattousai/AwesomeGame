class AwesomeGame extends UTDeathmatch;

var int EnemiesLeft;
var array<AwesomeEnemySpawner> EnemySpawners;

simulated function PostBeginPlay()
{
    local AwesomeEnemySpawner ES;

    super.PostBeginPlay();

    GoalScore = EnemiesLeft;

    foreach DynamicActors(class'AwesomeEnemySpawner',ES)
        EnemySpawners[EnemySpawners.length] = ES;

    `log("Number of Spawners:" @ EnemySpawners.length);
    ActivateSpawners();

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
    }
}

function ActivateSpawners()
{
    local int i;
    
    for(i=0; i < EnemySpawners.length; i++)
        EnemySpawners[i].TimedEnemySpawn();
}

defaultproperties
{
    EnemiesLeft=10
    PlayerControllerClass=class'AwesomeGame.AwesomePlayerController'
    DefaultPawnClass=class'AwesomeGame.AwesomePawn'
    bScoreDeaths=false
    DefaultInventory(0)=None
}