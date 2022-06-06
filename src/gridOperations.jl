
function computeGridNodes( grid )



  numVoxelsX   =       grid.voxelNums[1]
  numVoxelsXY  = prod( grid.voxelNums[1:2] )
  numVoxels    = prod( grid.voxelNums )

  nodesMat = zeros( numVoxels,3)
 for kg in ( 1:grid.voxelNums[3] )
    for jg in ( 1:grid.voxelNums[2] )
      for ig in ( 1:grid.voxelNums[1] )

        # number of voxel
        ind = (kg-1) * numVoxelsXY + (jg-1)*numVoxelsX + ig
        
        nodesMat[ind,:] = grid.startVox + grid.voxelWidths .* ([ ig, jg, kg ] .- 1 )

      end # loop x index
    end # loop y index
  end # loop z index

  return nodesMat
end