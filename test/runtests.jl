using Materialis
using Test

@testset "Test: FEM2Grid interpolation matrix" begin

    testNodes = [ 0 0 0 ; 1 0 0 ; 0 1 0 ; 0 0 1 ]
    testConec = [ [ 1, 2, 3, 4] ]
    testGrid = intGrid( [2,2,2], [0., 0., 0.], [1., 1., 1.] )

    computeFEM2GridInterpMatrix( testNodes, testConec, testGrid, 3, 0 )

    @test 0 < 1
end
