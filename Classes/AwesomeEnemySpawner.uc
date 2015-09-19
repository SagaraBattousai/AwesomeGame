class AwesomeEnemySpawner extends AwesomeActor
    placeable;

var TestEnemy MySpawnedEnemy;

function SpawnEnemy()
{
    if(MySpawnedEnemy == none)
        MySpawnedEnemy = spawn(class'TestEnemy',self,,Location);
}

function EnemyDied()
{
    TimedEnemySpawn();
}

function freezeEnemy()
{
    if(MySpawnedEnemy != none)
        MySpawnedEnemy.Freeze();
        
    ClearTimer('SpawnEnemy');
}

function TimedEnemySpawn()
{
    SetTimer(5.0 + FRand() * 5, false, 'SpawnEnemy');
}

defaultproperties
{
    begin Object Class=SpriteComponent Name=Sprite
        Sprite=Texture2D'EditorResources.S_NavP'
        HiddenGame=True
    End Object
    Components.Add(Sprite)
}