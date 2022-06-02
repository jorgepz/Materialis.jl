#= ==============================================================================
%
% function for computation of interpolation matrix from FEM mesh to regular grid
%    from displacements in tetraedra fem grid to a regular grid mesh
%
%  Inputs:
%    - Nodes
%    - Conec
%    - numComponentes: number of components of the magnitude to be interpolated
%    - order: 0 interpolates from elements centroids
%            1 interpolates from nodes
%
%
=#

function computeFEM2GridInterpMatrix( Nodes, Conec, intGrid, numCompon, order )
         
  numVoxelsX   =       intGrid.voxelNums[1]
  numVoxelsXY  = prod( intGrid.voxelNums[1:2] )
  numVoxels    = prod( intGrid.voxelNums )

  numNodes  = size( Nodes, 1)
  numElems  = length( Conec )

  @assert typeof(Conec) == Vector{ Vector{Int64} }

  print("typof Conec", typeof(Conec) )

  if order == 0
    interpMatrix = spzeros( numCompon * numVoxels, numCompon * numElems )
  # elseif order == 1
  #   interpMatrix = sparse( numCompon * numVoxels, numCompon * numNodes ) ;
  end

  booleanInterFound = zeros( Bool, numVoxels )

  print("boolean", booleanInterFound )
  # mySpEye = speye( numCompon, numCompon ) ;

  # loop in elements for see which grid nodes are in an element.
  for i in (1:numElems)

    nodesElem = Conec[i]
    coordesElem = Nodes[ nodesElem , :]
    print("nodes eleem", nodesElem)
    print("typof nodes eleem", typeof(nodesElem) )
    print("nodes", Nodes)
    
    print("coords eleme", coordesElem)
    print("size coords eleme", size(coordesElem) )

    # coordenadas de bounding box de elemento
    mins = vec( minimum( coordesElem, dims=1 ) )
    maxs = vec( maximum( coordesElem, dims=1 ) )
    
    # indexes of grid within bounding box
    indsIni, indsEnd = ranges( mins, maxs, intGrid )

    print("indsss ini end", indsIni, indsEnd )

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

              print("it is in tetra: ", itIsInTetra, "\n" )
              
              # if it is in the tetrahedron
              if itIsInTetra
                # then we found 
                booleanInterFound[ind] = true

                # dofsGrid = nodes2dofs( ind, numCompon )

                if order == 0
                   # assign interpolation of grid node ind to element i
                   interpMatrix[ind, i] = 1
                
    #             elseif order == 1
    #               % assign interpolation of grid node ind to nodes of element i
    #               dofsNodesTet = nodes2dofs( Conec(i,1:4) , numCompon ) ;
    #               %
    #               interpMatrix( dofsGrid, dofsNodesTet ) = [ mySpEye*shapeFuncs(1) ...
    #                                                         mySpEye*shapeFuncs(2) ...
    #                                                         mySpEye*shapeFuncs(3) ...
    #                                                         mySpEye*shapeFuncs(4) ] ;
                end # if order 

              end # if it is in tetra
            end # if node already analyzed
          end # loop x index
        end # loop y index
      end # loop z index
    end # if length inds > 0

  end # loop elements

  return interpMatrix
end


#= ==============================================================================
%
% funcion para calculo rangos de indices xyz de grid que efecitivamente caen dentro del box del elemento
% 
% ==============================================================================
=#

function ranges( mins, maxs, intGrid )
  
  endVox = intGrid.startVox + intGrid.voxelNums .* intGrid.voxelWidths
  print("end vox", endVox)
  
  # if the maximums of the box are higher than all components of the startVoxel
  # then there could be an intersection
  if ( sum( maxs .>= intGrid.startVox ) == 3 ) && ( sum( mins .<= endVox ) == 3 )
    # there is intersection
    print("there is intersection")
    indsEnd = Int.( min.( ceil.(  ( maxs - intGrid.startVox ) ./ intGrid.voxelWidths .+ 1 ), intGrid.voxelNums ) )
    indsIni = Int.( max.( floor.( ( mins - intGrid.startVox ) ./ intGrid.voxelWidths .+ 1 ), ones(3)           ) )
  else
    indsIni = []
    indsEnd = []
  end

  return indsIni, indsEnd
end


# ===========================================================================
# ===========================================================================
# ===========================================================================

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




function vecGridConvert(ind)

  return 1
end