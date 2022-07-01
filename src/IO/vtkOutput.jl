"""
vtkUnsGridPlot: function for writing vtk unstructured grid files and magnitudes

"""
function vtkUnsGridPlot( connec, nodes, nodalMagnitudes, filename )
    
    cells = MeshCell{VTKCellType, Vector{Int64}}[]
    for i in (1:size(connec,1) )
      push!(cells, MeshCell( VTKCellTypes.VTK_TETRA, connec[i] ) )
    end

    vtk_grid( filename, Array( nodes' ), cells ) do vtk
        vtk["magnitude", VTKPointData()] = nodalMagnitudes
    end
    
end

"""
vtkStrGridPlot: function for writing vtk structured grid files and magnitudes
 - nodalMagnitudes: vector of Any with [ magnitudes1, magnitudes2, ...]
"""
function vtkStrGridPlot( grid, nodalMagnitudes, filename )

  x, y, z = LinRange.( grid.startVox, grid.endVox, grid.voxelNums )

  # vtk_grid( filename, x, y, z,  append = false, ascii=true ) do vtk
  vtk_grid( filename, x, y, z ) do vtk
    for i in (1:length(nodalMagnitudes))
      vtk[ string("magnitude_",i), VTKPointData() ] = nodalMagnitudes[i]
    end
  end

end