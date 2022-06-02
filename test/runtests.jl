using Materialis
using Test

@testset "Test: FEM2Grid interpolation matrix" begin

    auxMin = -0.1
    auxMax = 1.5

    testNodes = [ auxMin auxMin auxMin ; auxMax auxMin auxMin ; auxMin auxMax auxMin ; auxMin auxMin auxMax ]
    testConec = [ [ 1, 2, 3, 4] ]

    iniG = 0.
    voxelWidth = .3
    numVoxPerDim = 4
    numVox = numVoxPerDim * ones(Int, 3)

    testGrid = intGrid( numVox , iniG*ones(3), voxelWidth*ones(3) )

    interpMatrix = computeFEM2GridInterpMatrix( testNodes, testConec, testGrid, 3, 0 )

    #print("AHHHHH:", Matrix(interpMatrix) )

    magnitude = rand( size(testNodes,1), 3 )

    # paraview output
    vtkUnsGridPlot( testConec, testNodes, magnitude, "unstrgrid" )

    magnitudes = [ rand( numVoxPerDim, numVoxPerDim, numVoxPerDim ), rand(3, numVoxPerDim, numVoxPerDim, numVoxPerDim )]

    vtkStrGridPlot( testGrid, magnitudes, "strgrid" )

    @test 0 < 1
end
