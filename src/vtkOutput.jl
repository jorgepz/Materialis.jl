
function vtkUnsGridPlot( connec, nodes, nodalMagnitudes, filename )
    
    # cells = []
    # for i in (1:size(connec,1) )
    #   push!(cells, MeshCell( VTKCellTypes.VTK_TETRA, connec[i] ) )
    # end

    cells=[ MeshCell( VTKCellTypes.VTK_TETRA, connec[1] )  ]

    vtk_grid( filename, Array( nodes' ) , cells ) do vtk
        vtk["magnitude", VTKPointData()] = nodalMagnitudes
    end
    
end


"""
vtkStrGridPlot: function for writing vtk grid files
 - nodalMagnitudes: vector of Any with [ magnitudes1, magnitudes2, ...]
"""
function vtkStrGridPlot( grid, nodalMagnitudes, filename )

  x = grid.startVox[1] : grid.voxelWidths[1] : ( grid.voxelWidths[1]*(grid.voxelNums[1]-1) )
  y = grid.startVox[2] : grid.voxelWidths[2] : ( grid.voxelWidths[2]*(grid.voxelNums[2]-1) )
  z = grid.startVox[3] : grid.voxelWidths[3] : ( grid.voxelWidths[3]*(grid.voxelNums[3]-1) )

  print( "type nodal mag", typeof(nodalMagnitudes), size( nodalMagnitudes[1] ) ) 

  vtk_grid( filename, x, y, z) do vtk
    for i in (1:length(nodalMagnitudes))
        print(x)
        print("holaaaa", i)
      vtk[ string("magnitude_",i), VTKPointData() ] = nodalMagnitudes[i]
    end
  end

end