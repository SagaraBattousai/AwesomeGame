class AwesomeGame extends UTDeathmatch;

simulated function PostBeginPlay()
{
    local TestEnemy TE;

    super.PostBeginPlay();

    GoalScore = 0;

    foreach DynamicActors(class'TestEnemy',TE)
        GoalScore++;

}

defaultproperties
{
    PlayerControllerClass=class'AwesomeGame.AwesomePlayerController'
    DefaultPawnClass=class'AwesomeGame.AwesomePawn'
    bScoreDeaths=false
    DefaultInventory(0)=None
}