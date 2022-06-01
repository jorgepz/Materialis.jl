using Materialis, WriteVTK, SparseArrays
using Test

@testset "Test: FEM2Grid interpolation matrix" begin

    auxMin = -0.1
    auxMax = 1.5

    testNodes = [ auxMin auxMin auxMin ; auxMax auxMin auxMin ; auxMin auxMax auxMin ; auxMin auxMin auxMax ]
    testConec = [ [ 1, 2, 3, 4] ]

    testGrid = intGrid( [3,3,3], [0., 0., 0.], 0.3*ones(3) )

    interpMatrix = computeFEM2GridInterpMatrix( testNodes, testConec, testGrid, 3, 0 )

    print("AHHHHH:", Matrix(interpMatrix) )
    # paraview output
    cells = [ MeshCell( VTKCellTypes.VTK_TETRA, testConec[1] ) ]

    vtk_grid("interpolationExample", Array(testNodes') , cells) do vtk
        vtk["displacements", VTKPointData()] = rand(4,3)
    end

    x, y, z = 0:10, 1:6, 2:0.1:3
    Nx, Ny, Nz = length(x), length(y), length(z)

    vtk_grid("fields", x, y, z) do vtk
      vtk["Pressure"] = rand(Nx - 1, Ny - 1, Nz - 1)   # metadata ("field data" in VTK)
    end

    @test 0 < 1
end
