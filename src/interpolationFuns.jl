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

#function computeFEM2GridInterpMatrix( Nodes, Conec, intGrid, numCompon, order )

function computeFEM2GridInterpMatrix( intGrid )
         
  print(intGrid.voxelNums)

#  numVoxels = prod( intGrid.voxelNums )

  # numNodes  = size(Nodes, 1) ;
  # numElems  = size(Conec, 1) ;

  # if order == 0
  #   interpMatrix = sparse( numCompon * numVoxels, numCompon * numElems ) ;
  # elseif order == 1
  #   interpMatrix = sparse( numCompon * numVoxels, numCompon * numNodes ) ;
  # end

  # booleanInterFound = zeros( numVoxels, 1 ) ;

  # mySpEye = speye( numCompon, numCompon ) ;

#  % loop in elements for see which grid nodes are in an element.
#  for i = 1 : numElems


    # coordesElem = Nodes( Conec( i,1:4) , :) ;
    
    # % coordenadas de boundix box de elemento
    # mins = min( coordesElem )' ;
    # maxs = max( coordesElem )' ;



    # [indsIni, indsEnd ] = ranges( mins, maxs, intGrid ) ;
    
    # if length( indsIni ) > 0
    #   for kg=indsIni(3):indsEnd(3)
    #     for jg=indsIni(2):indsEnd(2)
    #       for ig=indsIni(1):indsEnd(1)

    #         % number of voxel
    #         ind = (kg-1)*prod(intGrid.voxelNums(1:2)) + (jg-1)*intGrid.voxelNums(1) + ig ;
            
    #         % if an interpolation of the node was not already obtained
    #         if booleanInterFound(ind) == 0
    
    #           pointCand = intGrid.startVox + intGrid.voxelWidths .* ([ ig jg kg ]' -1) ;
              
    #           % verify if it belongs to the current element
    #           [itIsInTetra, shapeFuncs ] = checkInTetra( coordesElem , pointCand ) ;

    #           % if it is
    #           if itIsInTetra
    #             % then we found 
    #             booleanInterFound(ind) = 1 ;

    #             dofsGrid = nodes2dofs( ind, numCompon ) ;

    #             if order == 0
    #               % assign interpolation of grid node ind to element i
    #               interpMatrix( ind, i) = 1 ;
                
    #             elseif order == 1
    #               % assign interpolation of grid node ind to nodes of element i
    #               dofsNodesTet = nodes2dofs( Conec(i,1:4) , numCompon ) ;
    #               %
    #               interpMatrix( dofsGrid, dofsNodesTet ) = [ mySpEye*shapeFuncs(1) ...
    #                                                         mySpEye*shapeFuncs(2) ...
    #                                                         mySpEye*shapeFuncs(3) ...
    #                                                         mySpEye*shapeFuncs(4) ] ;
    #             end % if order 
    #           end % if it is in tetra
    #         end % if node already analyzed
    #       end % loop x index
    #     end % loop y index
    #   end % loop z index
    # end % if length inds > 0

#  end # loop elements

    return 1

end