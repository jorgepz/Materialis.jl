# example uniaxial extension
using Materialis

problem_name = "uniaxial_extension"

# reference material parameters
E_ref  = 2 
nu     = 0.4 

largo = 1
ladoSecc = .2
tension = 2.0

solver_params = SolidSolverParams("analytic", [ "ring_disps_fun", nu, tension ] )
# -----------------------------

# -----------------------------
# grid parameters
grid_start = [.25,.25]
grid_end   = grid_start .+ .5
num_voxels = [ 256, 256]  # roi 181

myGrid = create_grid( grid_start, grid_end, num_voxels )

# myROI  = ROIData( .4, .6, ladoSecc*0.25, ladoSecc*0.35, ladoSecc*0.25, ladoSecc*0.35    )


# plotParamsVector = [ 3 ]
# tolDeltaP        = 1e-4 # convergence criterion
# tolDeltaP = 1e-5 

