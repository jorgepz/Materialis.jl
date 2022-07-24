# example uniaxial extension
using Materialis

problem_name = "extension"

function extension_disps_fun( nodes_matrix, material, params )
    E = material
    nu, tension = params[2:end]
    C = tension * ( 1-nu-2*nu^2) / ( 1-nu )

    num_nodes = size( nodes_matrix, 1)

    disps = hcat(   C / E       * nodes_matrix[:,1], zeros( num_nodes ) )
    dudE  = hcat( - C / (E^2.0) * nodes_matrix[:,1], zeros( num_nodes ) )

    return disps, dudE
end

# -----------------------------
# reference material parameters
E_ref  = 2.0
nu     = 0.4 

largo = 1
ladoSecc = .2
tension = .2

solver_params = SolidSolverParams("analytic", [ "extension_disps_fun", nu, tension ] )
# -----------------------------


# -----------------------------
# image parameters

w = 100 
C = tension * ( 1-nu-2*nu^2) / ( 1-nu )

function extension_inten_fun( nodes_matrix, params )
    num_nodes = size( nodes_matrix, 1)
    return sin.( params * nodes_matrix[:,1] )
end

image_params = ImageParams( [ w, w*E_ref/(C+E_ref) ], extension_inten_fun )
# -----------------------------



# -----------------------------
# grid parameters
image_width = 0.5
grid_start  = [.25,.25,.0]
num_voxels  = [ 256, 256, 1 ]  # roi 181

grid_end   = grid_start .+ image_width

my_grid = create_grid( grid_start, grid_end, num_voxels )
my_ROI  = ROIData( [ .325, .325, .0 ], [ .675, .675, .0 ]    )

# -----------------------------


# generate data
measured_data = generate_data( problem_name, my_grid, E_ref, solver_params, image_params )
