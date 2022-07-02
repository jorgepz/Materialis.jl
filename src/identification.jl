"""
 - matParams: vector with material parameters
"""
function image_based_identification( imageFilenames, matParams, tolDeltaP, methodNumber, dispFuncName, tension )
    
    #=( tolDeltaP, pIni, nu, 
    imageFilenames, minsROI, maxsROI,
    nameOnsasFile, nLoadSteps, tension,
    optimMethodParams, voxelNums, intFun,
    strCase, flagsPyOct )
=#

    grid, intensities = read_vtk_grid_data( imageFilenames )

    #--------------
    #gradientes int
    # not by the moment
    #--------------


    #--------------

    if methodNumber == 0
        # brute force method

        for indMP in (1:length(matParams))
            print("\n", indMP,"\n", matParams[indMP] )

            u = compute_disps( dispFuncName, [matParams[indMP],0], tension )
        end
    end

    return 1
end


function compute_disps( dispFuncName, matParam, tension )

    u = eval( Symbol( dispFuncName ))( matParam, tension )
    return u
end
