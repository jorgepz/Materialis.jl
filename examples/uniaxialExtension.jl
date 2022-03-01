# example uniaxial extension
push!( LOAD_PATH, "../src")
using Materialis

myGrid = gridData( 100, 3, 3, .1*largo, .9*largo, ladoSecc*.1, ladoSecc*.5 , ladoSecc*.1, ladoSecc*.5 )
myROI  = ROIData( .4, .6, ladoSecc*0.25, ladoSecc*0.35, ladoSecc*0.25, ladoSecc*0.35    )

pRef             = 2   ;  % young reference
nu               = 0.4 ;
nLoadSteps       = 1   ;
levelerror       = 0.0 ;
plotParamsVector = [ 3 ] ;
tolDeltaP        = 1e-4 ;  % converge criterion

tolDeltaP = 1e-5 ;

cpenal  = 1e5 ;
