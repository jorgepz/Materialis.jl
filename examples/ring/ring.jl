

using Materialis

# Ring example

generateBoolean   = true

# outDir = '../../../...' ;

# geometry
r2 = 0.0024 ;
r1 = 0.0020 ;
lz = 0.001 

# generate fem mesh


mmHg2Pa = 133 
deltap  = 25  # mmHg

iniG = -0.003
endG = 0.003
numVoxPerDim = 50

include("ringInterpolFun.jl")

testGrid = createGrid( iniG*ones(3), endG*ones(3), numVoxPerDim )

gridNodes = computeGridNodes( testGrid )

print(gridNodes)
gridIntVals = ringInterpolFunc( gridNodes, r1, r2 )

print("\n\n", gridIntVals)

auxgridint = [ reshape( gridIntVals, (numVoxPerDim,numVoxPerDim,numVoxPerDim) ) ]

vtkStrGridPlot( testGrid, auxgridint, "ring_00" )

gridIntVals = ringInterpolFunc( gridNodes, r1*1.1, r2*1.2 )

auxgridint = [ reshape( gridIntVals, (numVoxPerDim,numVoxPerDim,numVoxPerDim) ) ]

vtkStrGridPlot( testGrid, auxgridint, "ring_01" )

# external box grid
# boxGrid = [   -3e-3    3e-3   ; ...
#               -3e-3     3e-3  ; ...
#               0.2*lz   lz*0.8 ] ;

# boxGrid = [ 0.1 0.9 ; -0.1 0.15 ; -0.1 0.15 ] ;

#voxelNums   = [ 100      ,  100        , 3        ]' ;  

#pRef             = 450e3   ;  % Pa
#nu               = 0.45 ;

#plotParamsVector = [ 3 ] ;

#minsROI = [ -3e-3 -3e-3  lz*0.45 ]' ;
#maxsROI = [  3e-3  3e-3  lz*0.55 ]' ;

#cpenal  = 1e5 ;
#tolDeltaP = 1e-5 ;

#nLoadSteps = 3 ;

#finalTension = mmHg2Pa*deltap*nLoadSteps 

#mu      = ( intensityFunctions( 1, 4 ) + intensityFunctions( 0, 4 ) ) / 2 ;
#halfDif = ( intensityFunctions( 1, 4 ) - intensityFunctions( 0, 4 ) ) / 2 ;

# paramsVals{1} = [ 4 ] ; % funcion

# paramsVals{2} = [ finalTension ] ; % tension

# paramsVals{3} = [ .5*pRef         ]' ; % vecPInis

# %~ paramsVals{4} = [ halfDif/4 halfDif/2 ]' ; % level error:    sigma = mu / SNR
# paramsVals{4} = [ 0 ]' ; % level error:    sigma = mu / SNR


# %~ methodNums = 0;  flagsPyOct = [0 1 ] ;
# methodNums = [  5] ; flagsPyOct = [] ; % identif octave

# realImagesBoolean = 0 ;

# strPaper = '../../../.....' ;

# % --- genera tex con valores de corridas de ejemplo ---
# fileParams = [ strPaper '/paramsTexs/' problemName '_Params.tex'] ;

# fp = fopen(fileParams,'w') ;
# fprintf(fp,'\\def\\exDosERef{%12.2e} \n', pRef);
# fprintf(fp,'\\def\\exDosnu{%3.2f} \n', nu);

# fprintf(fp,'\\def\\exDosNumVoxX{%4i} \n', voxelNums(1));
# fprintf(fp,'\\def\\exDosNumVoxY{%4i} \n', voxelNums(2));
# fprintf(fp,'\\def\\exDosNumVoxZ{%4i} \n', voxelNums(3));

# fprintf(fp,'\\def\\exUnoLength{%1.0f} \n', largo );
# fprintf(fp,'\\def\\exUnoLadoSecc{%5.2f} \n', ladoSecc );

# fclose(fp);


# ordenes deinterpolacion para cada funcion de intensidad de intensityFunctions.m
#vecIntenInterOrder = [ 1 1 1 0 ] ;


## generacion

# intValsSolid = intensityFunctions( Nodes(:,1), intFun ) ;  

# intValsDef = zeros( numVoxelsGrid, nLoadSteps+1 ) ;


# NodesDef = Nodes + reshape( matUs(1:2:end,i+1) , 3, size(Nodes,1) )' ;
    
# % interpolo desde nodos deformados a grid indeformada
# interpMatrix = computeInterpFEM2GridMat( NodesDef, Conec, intGrid, 1, vecIntenInterOrder(intFun) ) ;

# % calculo y agrego error
# intValsDef(:,i+1) = interpMatrix * intValsSolid + randn( numVoxelsGrid, 1)* levelerror ;
# end  % if real IMages ----


# % escribe imagen
# writeVTKGridData ( intGrid, intValsDef(:,i+1) , imageFileNames{i+1} ) ;  


