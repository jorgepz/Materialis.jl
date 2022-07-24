"""
Function that generates synthetic data.
"""
function generate_data( problem_name,  )

    # construct function names
    disps_func_name = problem_name * "_disps_fun"
    inten_func_name = problem_name * "_inten_fun"


    eval( Symbol( disps_func_name ) )( mat_param, solver_params.params )
    gridIntVals = ring_intens_fun( gridNodes, r1, r2 )
    auxgridint  = reshape( gridIntVals, (numVoxPerDim,numVoxPerDim,numVoxPerDim) )
    vtkStrGridPlot( my_grid, auxgridint, "ring_00" )

    gridIntVals = ring_intens_fun( gridNodes, r1*1.1, r2*1.2 )
    auxgridint = reshape( gridIntVals, (numVoxPerDim,numVoxPerDim,numVoxPerDim) )
    vtkStrGridPlot( testGrid, auxgridint, "ring_01" )
    return measured_data

end
