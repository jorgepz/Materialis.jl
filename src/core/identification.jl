"""
 - matParams: vector with material parameters
"""
function image_based_identification( imageFilenames, matParams, tolDeltaP, methodNumber, solver_params )
    
    #=( tolDeltaP, pIni, nu, 
    imageFilenames, minsROI, maxsROI,
    nameOnsasFile, nLoadSteps, tension,
    optimMethodParams, voxelNums, intFun,
    strCase, flagsPyOct )
=#

    grid, intensities = read_vtk_grid_data( imageFilenames )

    #--------------
    if methodNumber == 0

        # brute-force search
        for indMP in (1:length(matParams))
            print("\n", indMP, "\n", matParams[indMP] )

            u_grid = compute_disps( matParams[indMP], solver_params, grid )

            
        end


    end

    return 1
end

"""
Function that computes the displacement using external user-provided tools at the points of the image grid.
"""
function compute_disps( mat_param, solver_params, grid )

    if cmp( solver_params.solver_type, "analytic")==0

        disp_func_name = solver_params.params[1]

        u = eval( Symbol( disp_func_name ) )( nodes_matrix, mat_param, solver_params.params )



    end

    return u
end
