class TestEnemy extends AwesomeActor
    placeable;
    
var float BumpDamage;
var Pawn Enemy;
var float FollowDistance;
var float AttackDistance;

function Tick(float DeltaTime)
{
    local AwesomePlayerController PC;
    local vector NewLocation;

    if(Enemy == none)
    {
        foreach LocalPlayerControllers(class'AwesomePlayerController', PC)
        {
            if(PC.Pawn != none)
            {
                Enemy = PC.Pawn;
                `log("My Enemy is:" @ Enemy);
            }
        }
    }
    else if(VSize(Location - Enemy.Location) < FollowDistance)
    {
        if(Vsize(Location - Enemy.Location) < AttackDistance)
        {
            Enemy.Bump(self, CollisionComponent, vect(0,0,0));
        }
        else
        {
            NewLocation = location;
            newLocation += (Enemy.Location - Location) * DeltaTime;
            SetLocation(NewLocation);
        }
    }
}

event TakeDamage(int DamageAmount, Controller EventInstigator,
                 vector HitLocation, vector momentum, class<DamageType> DamageType,
                 optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    if(EventInstigator != none && EventInstigator.PlayerReplicationInfo != none){
        WorldInfo.Game.ScoreObjective(EventInstigator.PlayerReplicationInfo, 1);
    }

    Destroy();
}

defaultproperties
{

    BumpDamage=5.0
    FollowDistance=512.0
    AttackDistance=96.0

    bBlockActors=True
    bCollideActors=True
    
    Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
        bEnabled=TRUE
    End Object
    Components.Add(MyLightEnvironment)

    Begin Object Class=StaticMeshComponent Name=PickupMesh
        StaticMesh=StaticMesh'UN_SimpleMeshes.TexPropCube_Dup'
        Materials(0)=Material'EditorMaterials.WidgetMaterial_X'
        LightEnvironment=MyLightEnvironment
        Scale3D=(X=0.25,Y=0.25,Z=0.5)
    End Object
    Components.Add(PickupMesh)

    Begin Object Class=CylinderComponent Name=CollisionCylinder
        CollisionRadius=32.0
        CollisionHeight=64.0
        BlockNonZeroExtent=true
        BlockZeroExtent=true
        BlockActors=true
        CollideActors=true
    End Object
    CollisionComponent=CollisionCylinder
    Components.Add(CollisionCylinder)
}