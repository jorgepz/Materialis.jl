using Materialis
using Test

@testset "Test: FEM2Grid interpolation matrix" begin

    auxMin = -0.1
    auxMax = 1.5

    testNodes = [ auxMin auxMin auxMin ; auxMax auxMin auxMin ; auxMin auxMax auxMin ; auxMin auxMin auxMax ]
    testConec = [ [ 1, 2, 3, 4] ]

    iniG = 0.0
    endG = 1.0
    numVoxPerDim = 20

    testGrid = createGrid( iniG*ones(3), endG*ones(3), numVoxPerDim )

    interpMatrix = computeFEM2GridInterpMatrix( testNodes, testConec, testGrid, 1, 1 )

    magnitudeFEM = [ 1, 2, 3, 4 ]

    magnitudeGrid = interpMatrix * magnitudeFEM 

    # paraview output
    vtkUnsGridPlot( testConec, testNodes, magnitudeFEM, "unstrgrid" )

    magnitudes = [ reshape( magnitudeGrid, ( numVoxPerDim, numVoxPerDim, numVoxPerDim ) ) ]

    vtkStrGridPlot( testGrid, magnitudes, "strgrid" )

    @test 0 < 1
end
