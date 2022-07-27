"""
Function that generates synthetic data.
"""
function generate_data( problem_name, grid, mat_param, solver_params, image_params )

    measured_data = []

    grid_nodes = compute_grid_nodes( grid )

    # -------------------------------
    u, _ = solver_params.disps_fun( grid_nodes, mat_param, solver_params.params )

    nIm = length( u )+1

    # generates vtis
    for i in (1:nIm)
        vti_name = problem_name * "_" * string(i,pad=2)
        gridIntVals = image_params.inten_fun( grid_nodes, image_params.image_gener_params[i] )
        auxgridint  = reshape( gridIntVals, Tuple( grid.voxelNums) )
        vtkStrGridPlot( grid, auxgridint, vti_name )
        push!( measured_data, vti_name ) 
    end

    return measured_data
end
