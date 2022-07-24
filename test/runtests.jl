using Materialis
using Test

@testset "Materialis" begin

    # generate the FEM mesh
    Lx = 0.5;  Ly = 1.0;  Lz = 1.2

    testNodes = [ 0    0    0 ;
                  0    0   Lz ;
                  0   Ly   Lz ;
                  0   Ly    0 ;
                  Lx   0    0 ;
                  Lx   0   Lz ;
                  Lx  Ly   Lz ;
                  Lx  Ly    0 ] 

    testConec = [ [ 1, 4, 2, 6 ], 
                  [ 6, 2, 3, 4 ],
                  [ 4, 3, 6, 7 ],
                  [ 4, 1, 5, 6 ],
                  [ 4, 6, 5, 8 ],
                  [ 4, 7, 6, 8 ] ]

    # generate the image grid
    iniG = -0.2
    endG = 1.0
    numVox = [ 10, 5, 8]
    testGrid = create_grid( iniG*ones(3), endG*ones(3), numVox )

    # generate synthetic intensity in FEM mesh
    Ix, Iy, Iz = [.2, .3, -.4]
    magnitudeFEM = [ testNodes[i,1]*Ix+testNodes[i,2]*Iy+testNodes[i,3]*Iz  for i in (1:8) ]

    # interpolate intensity
    interpMatrix = computeFEM2GridInterpMatrix( testNodes, testConec, testGrid, 1, 1 )
    magnitudeGrid = interpMatrix * magnitudeFEM

    # paraview output of unstructured FEM mesh data
    vtkUnsGridPlot( testConec, testNodes, magnitudeFEM, "testunstrgrid" )

    # paraview output of structured grid data
    magnitudes = reshape( magnitudeGrid, ( numVox[1], numVox[2], numVox[3] ) )
    vtkStrGridPlot( testGrid, magnitudes, "teststrgrid" )

    numericalInte = magnitudes[3,2,2]
    analyticaInte = sum( ( testGrid.voxelWidths .* [2,1,1] .+ testGrid.startVox ) .* [Ix,Iy,Iz] )

    @test abs( numericalInte - analyticaInte ) < ( 1.0e-8*abs(analyticaInte) )

    
    include("../examples/extension/extension.jl")

end
