class AwesomeHUD extends UTGFxHUDWrapper;

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    `log("AwesomeHUD spawned!========================================");
}

event DrawHUD()
{
    super.DrawHUD();
    
    Canvas.DrawColor = WhiteColor;
    Canvas.Font = class'Engine'.Static.GetLargeFont();

    if(PlayerOwner.Pawn != none && AwesomeWeapon(PlayerOwner.Pawn.Weapon) != none)
    {
        Canvas.SetPos(Canvas.ClipX * 0.1, Canvas.ClipY * 0.9);
        Canvas.DrawText("Weapon Level:" @ AwesomeWeapon(PlayerOwner.Pawn.Weapon).CurrentWeaponLevel);
    }
    if(AwesomeGame(WorldInfo.Game) != none)
    {
        Canvas.SetPos(Canvas.ClipX * 0.1, Canvas.ClipY * 0.95);
        canvas.DrawText("Enemies Killed:" @ AwesomeGame(WorldInfo.Game).GoalScore - AwesomeGame(WorldInfo.Game).EnemiesLeft);
    }
    
    if(AwesomeGame(WorldInfo.Game) != none && !AwesomeGame(WorldInfo.Game).bFirstEnemySpawned &&
        AwesomeGame(WorldInfo.Game).IsTimerActive('ActivateSpawners'))
        {
            Canvas.SetPos(Canvas.ClipX * 0.1, Canvas.ClipY * 0.85);
            Canvas.DrawText("Time Left To First Spawn:" @ AwesomeGame(WorldInfo.Game).GetRemainingTimeForTimer('ActivateSpawners'));
        }
}

defaultproperties
{
}