"""
vtkUnsGridPlot: function for writing vtk unstructured grid files and magnitudes

"""
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
vtkStrGridPlot: function for writing vtk structured grid files and magnitudes
 - nodalMagnitudes: vector of Any with [ magnitudes1, magnitudes2, ...]
"""
function vtkStrGridPlot( grid, nodalMagnitudes, filename )

  x = grid.startVox[1] : grid.voxelWidths[1] : grid.endVox[1]
  y = grid.startVox[2] : grid.voxelWidths[2] : grid.endVox[2]
  z = grid.startVox[3] : grid.voxelWidths[3] : grid.endVox[3]

#  vtk_grid( filename, x, y, z,  append = false, ascii=true ) do vtk
  vtk_grid( filename, x, y, z ) do vtk
    for i in (1:length(nodalMagnitudes))
      vtk[ string("magnitude_",i), VTKPointData() ] = nodalMagnitudes[i]
    end
  end

end