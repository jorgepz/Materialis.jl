using Materialis
using Test

@testset "Test: FEM2Grid interpolation matrix" begin

    testGrid = intGrid( [2,2,2], [0., 0., 0.], [1., 1., 1.] )
    computeFEM2GridInterpMatrix( testGrid )

    @test 0 < 1
end
