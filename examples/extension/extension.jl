# example uniaxial extension
using Materialis

problem_name = "extension"

# -----------------------------
# reference material parameters
E_ref  = 2 
nu     = 0.4 

largo = 1
ladoSecc = .2
tension = 2.0

solver_params = SolidSolverParams("analytic", [ "extension_disps_fun", nu, tension ] )
# -----------------------------


# -----------------------------
# grid parameters
image_width = 0.5
grid_start  = [.25,.25,.0]
num_voxels  = [ 256, 256,1]  # roi 181

grid_end   = grid_start .+ image_width

my_grid = create_grid( grid_start, grid_end, num_voxels )
my_ROI  = ROIData( [ .325, .325, .0 ], [ .675, .675, .0 ]    )

grid_nodes = compute_grid_nodes( my_grid );
# -----------------------------


# generate data
#measured_data = generate_data( problem_name )

