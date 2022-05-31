
# ----------------------------------------------------------------------
#
# matrix for interpolation from displacements in tetraedra fem grid to a regular grid mesh
#
# numComponentes: number of components of the magnitude to be interpolated
#
# ----------------------------------------------------------------------

function MatInt = interpFEMGrid2Points( Nodes, Conec, NodesToEval, numComponents )

numVoxels = prod( intGrid.voxelNums ) ;

numNodes = size(Nodes, 1) ;
numNodesToEval = size(NodesToEval, 1) ;

MatInt   = sparse( numComponents * numNodesToEval, numComponents * numNodes ) ;

booleanGridAnalyzed = zeros( numNodesToEval, 1 ) ;

for i=1:numNodesToEval
  
  xact = NodesToEval( i, : )' ;

  indsEnd = min( ceil(  ( xact - intGrid.startVox ) ./ intGrid.voxelWidths + 1 ) , intGrid.voxelNums ) ;
    
  coordesElem = Nodes( Conec( i,1:4) , :) ;
  
  % coordenadas de boundix box de elemento
  mins = min( coordesElem )' ;
  maxs = max( coordesElem )' ;

  [indsIni, indsEnd ] = ranges( mins, maxs, intGrid ) ;
  
  if length(indsIni) > 0  
    for kg=indsIni(3):indsEnd(3)
      for jg=indsIni(2):indsEnd(2)
        for ig=indsIni(1):indsEnd(1)
    
          ind = (kg-1)*prod(intGrid.voxelNums(1:2)) + (jg-1)*intGrid.voxelNums(1) + ig ;
          
          if booleanGridAnalyzed(ind) == 0
  
            pointCand = intGrid.startVox + intGrid.voxelWidths .* ([ ig; jg; kg ] -1)  ;
            
            [itIsInTetra, shapeFuncs ] = checkInTetra( coordesElem , pointCand ) ;

            if itIsInTetra
              dofsGrid = nodes2dofs( ind, numComponents ) ;
              for sf=1:4
                dofsNodeTet = nodes2dofs( Conec(i,sf) , numComponents ) ;
                MatInt( dofsGrid, dofsNodeTet ) = speye( numComponents, numComponents ) * shapeFuncs(sf) ;
              end
              booleanGridAnalyzed(ind) = 1 ;
            end
          end % if node already analyzed
          
        end % loop x index
      end % loop y index
    end % loop z index
  end

end % loop elements


% funcion para calculo rangos de indices xyz de grid que efecitivamente caen dentro del box del elemento
% 
function [ indsIni, indsEnd] = ranges( mins, maxs, intGrid ) ;

  indsIni = []; indsEnd = [];
  
  endVox = intGrid.startVox + intGrid.voxelNums .* intGrid.voxelWidths ;
  
  % if the maximums of the box are higher than all components of the startVoxel
  % then there could be an intersection
  if ( sum( maxs >= intGrid.startVox ) == 3 )  && ( sum( mins <= endVox ) == 3 )  %
    % there is intersection
    indsEnd = min( ceil(  ( maxs - intGrid.startVox ) ./ intGrid.voxelWidths + 1 ) , intGrid.voxelNums ) ;
    indsIni = max( floor( ( mins - intGrid.startVox ) ./ intGrid.voxelWidths + 1 ) , ones(3,1)         ) ;
  end
