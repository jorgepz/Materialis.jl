
function vtkUnsGridPlot( connec, nodes, magnitude )
    
    # cells = []
    # for i in (1:size(connec,1) )
    #   push!(cells, MeshCell( VTKCellTypes.VTK_TETRA, connec[i] ) )
    # end

    cells=[ MeshCell( VTKCellTypes.VTK_TETRA, connec[1] )  ]

    vtk_grid("unsgrid", Array( nodes' ) , cells ) do vtk
        vtk["displacements", VTKPointData()] = magnitude
    end
    
end



# function vtkUnsGridPlot( connec, nodes, grid,  )

#     cells = [] 
#     for i in (1:size(connec,1) )
#       push!(cells, MeshCell( VTKCellTypes.VTK_TETRA, connec[1] ) )
#     end

#     vtk_grid("interpolationExample", Array( nodes' ) , cells ) do vtk
#         vtk["displacements", VTKPointData()] = rand(4,3)
#     end
    
#     pos = iniG:voxelWidth:voxelWidth*(numVox[1]-1)
#     x, y, z = pos, pos, pos
#     Nx, Ny, Nz = numVox

#     vtk_grid("fields", x, y, z) do vtk
#       vtk["intensity",VTKPointData()] = rand(Nx , Ny , Nz)   # metadata ("field data" in VTK)
#     end

# end