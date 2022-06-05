"""
 function for computation of interpolation matrix from FEM mesh to regular grid
    from displacements in tetraedra fem grid to a regular grid mesh

  Inputs:
    - Nodes: matrix with coordinates of nodes of the FEMmesh
    - Conec: vector of vectors. at i-th entry has the vector with the connectivity indexes
    - numComponentes: number of components of the magnitude to be interpolated
    - order: 0 interpolates from elements centroids
            1 interpolates from nodes
"""

function computeFEM2GridInterpMatrix( Nodes, Conec, intGrid, numCompon, order )
         
  numVoxelsX   =       intGrid.voxelNums[1]
  numVoxelsXY  = prod( intGrid.voxelNums[1:2] )
  numVoxels    = prod( intGrid.voxelNums )

  numNodes  = size( Nodes, 1)
  numElems  = length( Conec )

  @assert typeof(Conec) == Vector{ Vector{Int64} }

  booleanInterFound = zeros( Bool, numVoxels )

  rowIndexes = Vector{Int}()
  colIndexes = Vector{Int}()
  nonZerVals = Vector{Float64}()

  if order == 1
    totalRows = numCompon * numVoxels
    totalCols = numCompon * numNodes
  end

  # loop in elements for see which grid nodes are in an element.
  for i in (1:numElems)

    nodesElem   = Conec[i]
    coordesElem = Nodes[ nodesElem , :]
    
    # coordenadas de bounding box de elemento
    mins = vec( minimum( coordesElem, dims=1 ) )
    maxs = vec( maximum( coordesElem, dims=1 ) )
    
    # indexes of grid within bounding box
    indsIni, indsEnd = ranges( mins, maxs, intGrid )

    if length( indsIni ) > 0

      for kg in (indsIni[3]:indsEnd[3])
        for jg in (indsIni[2]:indsEnd[2])
          for ig in (indsIni[1]:indsEnd[1])

            # number of voxel
            ind = (kg-1) * numVoxelsXY + (jg-1)*numVoxelsX + ig ;
            
            # if an interpolation of the node was not already obtained
            if !(booleanInterFound[ind])

              pointCand = intGrid.startVox + intGrid.voxelWidths .* ([ ig, jg, kg ] .- 1 )

              # verify if it belongs to the current element
              itIsInTetra, shapeFuncs = checkInTetra( coordesElem, pointCand )

              # if it is in the tetrahedron
              if itIsInTetra
                # then we found it
                booleanInterFound[ind] = true

                dofsGridInd = nodes2dofs( ind, numCompon )

                # if order == 0
                #    # assign interpolation of grid node ind to element i
                #    interpMatrix[ind, i] = 1
                
                if order == 1
  
                  for indShapeFunc in (1:length(shapeFuncs))

                    dofsNode = nodes2dofs( nodesElem[indShapeFunc], numCompon )
  
                    append!( rowIndexes, dofsGridInd )
                    append!( colIndexes, dofsNode    )
                    append!( nonZerVals, shapeFuncs[ indShapeFunc ]*ones(numCompon) )

                  end

                end # if order 

              end # if it is in tetra
            end # if node already analyzed
          end # loop x index
        end # loop y index
      end # loop z index
    end # if length inds > 0

  end # loop elements

  return sparse( rowIndexes, colIndexes, nonZerVals, totalRows, totalCols )
end


"""
 funcion para calculo rangos de indices xyz de grid que efecitivamente caen dentro del box del elemento
"""

function ranges( mins, maxs, intGrid )
  
  # if the maximums of the box are higher than all components of the startVoxel
  # then there could be an intersection
  if ( sum( maxs .>= intGrid.startVox ) == 3 ) && ( sum( mins .<= intGrid.endVox ) == 3 )
    # there is intersection
    indsEnd = Int.( min.( ceil.(  ( maxs - intGrid.startVox ) ./ intGrid.voxelWidths .+ 1 ), intGrid.voxelNums ) )
    indsIni = Int.( max.( floor.( ( mins - intGrid.startVox ) ./ intGrid.voxelWidths .+ 1 ), ones(3)           ) )
  else
    indsIni = []
    indsEnd = []
  end

  return indsIni, indsEnd
end


"""
TO DO
"""

function checkInTetra( nodesTetra, pointCand )
 
  A          = zeros(4,4)
  A[:, 1]   .= 1.0 
  A[:, 2:4] .= nodesTetra
  volTot     = det(A) / 6.0

  volsRel = zeros(4) 
 
  boolInTetra = true
  i=0
  while boolInTetra && i<4
    i = i + 1

    B        = copy(A)
    B[i,2:4] = pointCand
    volsRel[i] = ( det( B ) / 6.0 ) / volTot ;
    
    boolInTetra = boolInTetra && ( volsRel[i] >= -1.0e-10 )
  end
  
  if boolInTetra
    shapeFuncs = volsRel
  else
    shapeFuncs = []
  end

  return boolInTetra, shapeFuncs
end


"""
TO DO
"""

function vecGridConvert(ind)

  return 1
end



"""

copied from
https://github.com/jorgepz/FEMAssembler.jl/blob/main/src/mesh/dofsComputations.jl

"""
function nodes2dofs( nodes , degreespernode )
    n    = length(nodes);
    dofs = zeros( Int, n*degreespernode ) ;
    for i in (1:n);
        dofs[ (i-1)*degreespernode .+ Vector(1:degreespernode) ] = (degreespernode*(nodes[i]-1)).+Vector(1:degreespernode)  ;
    end
    return dofs;
end
