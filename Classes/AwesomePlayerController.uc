class AwesomePlayerController extends UTPlayerController;

var vector PlayerViewOffset;

var vector CurrentCameraLocation, DesiredCameraLocation;

var rotator CurrentCameraRotation;

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    bNoCrosshair = true;
}

function NotifyChangedWeapon(Weapon PrevWeapon, Weapon NewWeapon)
{
    super.NotifyChangedWeapon(PrevWeapon, NewWeapon);
    
    NewWeapon.SetHidden(true);

    if(Pawn == none)
        return;
        
    if(UTWeap_RocketLauncher(NewWeapon) != none)
        Pawn.SetHidden(true);
    else
        pawn.SetHidden(false);
}

exec function StartFire( optional byte FireModeNum )
{
    super.StartFire(FireModeNum);
    
    if(Pawn != none && UTWeap_RocketLauncher(Pawn.Weapon) != none)
    {
        pawn.SetHidden(false);
        SetTimer(1, false, 'MakeMeInvisible');
    }
}

function MakeMeInvisible()
{
    if(Pawn != none && UTWeap_RocketLauncher(Pawn.Weapon) != none)
        Pawn.SetHidden(true);
 }


simulated event GetPlayerViewPoint(out vector out_Location, out rotator out_Rotation)
{
    super.GetPlayerViewPoint(out_Location, out_Rotation);

    if(Pawn != none){

        out_Location = CurrentCameraLocation;
        out_Rotation = rotator((out_Location * vect(1,1,0)) - out_Location);
    }
    
    CurrentCameraRotation = out_Rotation;
}

function PlayerTick(float DeltaTime)
{
    super.PlayerTick(DeltaTime);

    if(Pawn != none){
        DesiredCameraLocation = Pawn.Location + (PlayerViewOffset >> Pawn.Rotation);
        CurrentCameraLocation += (DesiredCameraLocation - CurrentCameraLocation) * DeltaTime * 3;
    }
}

function Rotator GetAdjustedAimFor(Weapon W, vector startFireLoc)
{
    return Pawn.Rotation;
}

state PlayerWalking
{
    function ProcessMove(float DeltaTime, vector newAccel,eDoubleClickDir DoubleClickMove,
                rotator DeltaRot)
    {
        local vector X, Y, Z, AltAccel;

        GetAxes(CurrentCameraRotation, X, Y, Z);
        AltAccel = PlayerInput.aFoward * Z + PlayerInput.aStrafe * Y;
        AltAccel.Z = 0;
        AltAccel = Pawn.AccelRate * Normal(AltAccel);

        super.ProcessMove(DeltaTime, AltAccel, DoubleClickMove, DeltaRot);
    }
}

defaultproperties
{
    PlayerViewOffset=(X=384,Y=0,Z=1024)
}