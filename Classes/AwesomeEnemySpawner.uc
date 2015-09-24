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
    SpawnEnemy();
}

function freezeEnemy()
{
    if(MySpawnedEnemy != none)
        MySpawnedEnemy.Freeze();
}

function bool CanSpawnEnemy()
{
    return MySpawnedEnemy == none;
}

defaultproperties
{
    begin Object Class=SpriteComponent Name=Sprite
        Sprite=Texture2D'EditorResources.S_NavP'
        HiddenGame=True
    End Object
    Components.Add(Sprite)
}