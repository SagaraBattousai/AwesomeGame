class AwesomeEnemySpawner extends AwesomeActor
    placeable;
    
function SpawnEnemy()
{
    `log("SpawnEnemy Called==================================");
}

defaultproperties
{
    begin Object Class=SpriteComponent Name=Sprite
        Sprite=Texture2D'EditorResources.S_NavP'
        HiddenGame=True
    End Object
    Components.Add(Sprite)
}