class AwesomePawn extends UTPawn;

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    
    if(ArmsMesh[0] != none)
        ArmsMesh[0].SetHidden(true);
    if(ArmsMesh[1] != none)
        ArmsMesh[1].SetHidden(true);

}

simulated function SetMeshVisibility(bool bVisable)
{
    super.SetMeshVisibility(bVisable);
    
    Mesh.SetOwnerNoSee(false);
}

defaultproperties
{
}