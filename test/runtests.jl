using Materialis
using WriteVTK
using Test

@testset "Test: FEM2Grid interpolation matrix" begin

    auxMin = -0.1
    auxMax = 1.5

    testNodes = [ auxMin auxMin auxMin ; auxMax auxMin auxMin ; auxMin auxMax auxMin ; auxMin auxMin auxMax ]
    testConec = [ [ 1, 2, 3, 4] ]

    testGrid = intGrid( [2,2,2], [0., 0., 0.], [1., 1., 1.] )

    computeFEM2GridInterpMatrix( testNodes, testConec, testGrid, 3, 0 )

    # paraview output
    cells = [ MeshCell( VTKCellTypes.VTK_TETRA, testConec[1] ) ]

    vtk_grid("interpolationExample", Array(testNodes') , cells) do vtk
        vtk["displacements", VTKPointData()] = rand(4,3)
    end

    @test 0 < 1
end
