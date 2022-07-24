"""
Function that generates synthetic data.
"""
function generate_data( problem_name, grid, mat_param, solver_params, image_params )

    measured_data = []

    # construct function names
    disps_func_name = problem_name * "_disps_fun"
    inten_func_name = problem_name * "_inten_fun"

    include( disps_func_name * ".jl" )
    include( inten_func_name * ".jl" )
    
    grid_nodes = compute_grid_nodes( grid )

    # -------------------------------
    #u = eval( Symbol( disps_func_name ) )( grid_nodes, mat_param, solver_params.params )

    # generates vti 0
#    gridIntVals = eval( Symbol( inten_func_name ) )( grid_nodes, image_params.image_gener_params[1] )
    gridIntVals = image_params.inten_fun( grid_nodes, image_params.image_gener_params[1] )
    auxgridint  = reshape( gridIntVals, Tuple( grid.voxelNums) )
    vtkStrGridPlot( grid, auxgridint, problem_name * "_00" )
    push!( measured_data, problem_name * "_00" ) 


    # # generates vti 1
    # gridIntVals = eval( Symbol( inten_func_name ) )( grid_nodes, image_params.image_gener_params[2] )
    # auxgridint  = reshape( gridIntVals, Tuple( grid.voxelNums) )
    # vtkStrGridPlot( grid, auxgridint, problem_name * "_01" )
    # push!( measured_data, problem_name * "_01" ) 

    return measured_data
end
