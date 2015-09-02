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
    EnemiesLeft--;
    super.ScoreObjective(Scorer, Score);
}

function ActivateSpawners()
{
    local int i;
    
    for(i=0; i < EnemySpawners.length; i++)
        EnemySpawners[i].SpawnEnemy();
}

defaultproperties
{
    EnemiesLeft=10
    PlayerControllerClass=class'AwesomeGame.AwesomePlayerController'
    DefaultPawnClass=class'AwesomeGame.AwesomePawn'
    bScoreDeaths=false
    DefaultInventory(0)=None
}