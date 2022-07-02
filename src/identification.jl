"""
 - matParams: vector with material parameters
"""
function image_based_identification( imageFilenames, matParams, tolDeltaP, methodNumber )
    
    #=( tolDeltaP, pIni, nu, 
    imageFilenames, minsROI, maxsROI,
    nameOnsasFile, nLoadSteps, tension,
    optimMethodParams, voxelNums, intFun,
    strCase, flagsPyOct )
=#

    [grid, intensities ] = read_vtk_grid_data( imageFilenames )


    #--------------
    #gradientes int

    #--------------


    #--------------

    if methodNumber == 0
        # brute force method

        for indMP in (1:length(matParams))
            print("\n", indMP,"\n", matParams[indMP] )
        end
    end

    return 1
end


function compute_disps( dispFuncName, tension, matParam )
    
    u, dudp = eval( Symbol( dispFuncName ))(tension, matParam)
    return u, dudp

end
