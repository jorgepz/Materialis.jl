
# % ----------------------------------------------------------------------
# %
# % matrix for interpolation from displacements in tetraedra fem grid to a regular grid mesh
# %
# % numComponentes: number of components of the magnitude to be interpolated
# %
# % ----------------------------------------------------------------------

# function MatInt = interpFEMGrid2Points( Nodes, Conec, intGrid, NodesToEval, numComponents )

# %~ numVoxels = prod( intGrid.voxelNums ) ;

# numNodes = size(Nodes, 1) ;
# numNodesToEval = size(NodesToEval, 1) ;

# MatInt   = sparse( numComponents * numNodesToEval, numComponents * numNodes ) ;

# %~ NodesToEval = redondeaCero( NodesToEval ) ;

# inds = zeros( numNodesToEval, 3) ;
# inds(:,1) = ( NodesToEval(:,1) - intGrid.startVox(1) ) / intGrid.voxelWidths(1) ; 
# inds(:,2) = ( NodesToEval(:,2) - intGrid.startVox(2) ) / intGrid.voxelWidths(2) ;
# inds(:,3) = ( NodesToEval(:,3) - intGrid.startVox(3) ) / intGrid.voxelWidths(3) ;
# %~ inds(:,3) = ( NodesToEval(:,3) - intGrid.startVox(3) + intGrid.voxelWidths(3) ) / intGrid.voxelWidths(3) - 1;

# inds = floor( redondeaCero ( inds )  ) + 1 ;

# %~ NodesToEval

# for i=1:numNodesToEval
# %~ for i=10:13

#   %~ NodesToEval(i,:)
#   indsBase = inds(i,:)' ;

#   %~ hola = ( NodesToEval(i,:)' - intGrid.startVox ) ./ intGrid.voxelWidths 
# %~ hola(1)-2
# %~ hola(2)
# %~ hola(3)

#   %~ floor ( ( NodesToEval(i,:)' - intGrid.startVox ) ./ intGrid.voxelWidths )
    
#   % me fijo si cae dentro de los grids
#   if ( sum( indsBase >= 1  ) == 3 ) && ( sum( indsBase <= (intGrid.voxelNums -1) ) == 3 ),
#     %~ disp('caaaa dentro ')

#     ix = indsBase(1) ;     iy = indsBase(2) ;    iz = indsBase(3) ;

#     i1 = (iz  -1)*prod( intGrid.voxelNums(1:2) ) + (iy  -1)*intGrid.voxelNums(1) + ix   ;
#     i2 = (iz+1-1)*prod( intGrid.voxelNums(1:2) ) + (iy  -1)*intGrid.voxelNums(1) + ix   ;
#     i3 = (iz+1-1)*prod( intGrid.voxelNums(1:2) ) + (iy+1-1)*intGrid.voxelNums(1) + ix   ;
#     i4 = (iz  -1)*prod( intGrid.voxelNums(1:2) ) + (iy+1-1)*intGrid.voxelNums(1) + ix   ;
#     i5 = (iz  -1)*prod( intGrid.voxelNums(1:2) ) + (iy  -1)*intGrid.voxelNums(1) + ix+1 ;
#     i6 = (iz+1-1)*prod( intGrid.voxelNums(1:2) ) + (iy  -1)*intGrid.voxelNums(1) + ix+1 ;
#     i7 = (iz+1-1)*prod( intGrid.voxelNums(1:2) ) + (iy+1-1)*intGrid.voxelNums(1) + ix+1 ;
#     i8 = (iz  -1)*prod( intGrid.voxelNums(1:2) ) + (iy+1-1)*intGrid.voxelNums(1) + ix+1 ;
    
#     conecLoc = ... 
#       [ i1 i3 i2 i6 ; ...
#         i1 i5 i4 i6 ; ...
#         i1 i4 i3 i6 ; ...
#         i6 i7 i8 i3 ; ...
#         i4 i8 i3 i6 ; ...
#         i4 i8 i6 i5 ]      ;
       
#     noEncontre = 1 ;
#     indTet     = 0 ;
    
#     while noEncontre
#       indTet = indTet + 1 ;
        
#       coordesElem = Nodes( Conec( i,1:4) , :) ;
      
#       if indTet == 7,

# %~ [ Nodes NodesToEval ]

#         %~ NodesToEval(i,:)
#         %~ indsBase
        
#         %~ Nodes( unique( conecLoc( :,1:4) ) , :)
#         %~ conecLoc


#         %~ warning('ojoooo No encontro ningun tetraedro'),
#         error('ojoooo No encontro ningun tetraedro'),
#       end
#       nodesTet = conecLoc( indTet, 1:4 ) ;
      
#       [itIsInTetra, shapeFuncs ] = checkInTetra( Nodes( conecLoc( indTet,1:4) , :) , NodesToEval(i,:)' ) ;

#       if itIsInTetra
#         dofsGrid = nodes2dofs( i, numComponents ) ;
#         for sf=1:4
#           conecLoc(indTet,sf) ;
#           dofsNodeTet = nodes2dofs( conecLoc(indTet,sf) , numComponents ) ;
#           MatInt( dofsGrid, dofsNodeTet ) = speye( numComponents, numComponents ) * shapeFuncs(sf) ;
#         end
#         %~ booleanGridAnalyzed(ind) = 1 ;
#         %~ disp('siiiiiiiiiiiiiiii');
#         noEncontre = 0 ;
#       end
      
      
#     end % if node already analyzed
    
#   else
#     %~ disp('-----------  no cae dentro -------------------')
#   end
# end
