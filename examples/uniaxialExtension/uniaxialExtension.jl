# example uniaxial extension
push!( LOAD_PATH, "../src")

using Materialis

# reference material parameters
pRef             = 2 
nu               = 0.4 

largo = 1
ladoSecc = .2

Lx = largo; Ly = ladoSecc ; Lz = Ly;

nodalCoords = [ 0    0    0 ; 
                0    0   Lz ; 
                0   Ly   Lz ; 
                0   Ly    0 ; 
                Lx   0    0 ; 
                Lx   0   Lz ; 
                Lx  Ly   Lz ; 
                Lx  Ly    0 ] 

# the connectivity matrix is given by a vector of vectors.
elemNodalConnec =[[ 1 4 2 6 ] , 
                  [ 6 2 3 4 ] , 
                  [ 4 3 6 7 ] , 
                  [ 4 1 5 6 ] , 
                  [ 4 6 5 8 ] , 
                  [ 4 7 6 8 ]  ]

nLoadSteps       = 1   
levelerror       = 0.0 

myGrid = gridData( 100, 3, 3, .1*largo, .9*largo, ladoSecc*.1, ladoSecc*.5 , ladoSecc*.1, ladoSecc*.5 )
myROI  = ROIData( .4, .6, ladoSecc*0.25, ladoSecc*0.35, ladoSecc*0.25, ladoSecc*0.35    )


plotParamsVector = [ 3 ]
tolDeltaP        = 1e-4 # convergence criterion
tolDeltaP = 1e-5 

