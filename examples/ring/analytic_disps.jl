
function analytic_disps( matParams, tension )

    E  = matParams[1]
    nu = matParams[2]

    p = tension

    Ri = r1
    Re = r2
    
    A = ( p * (1+nu)*(1-2*nu)*Ri^2 ) / ( E*(Re^2-Ri^2) )
    B = ( p * (1+nu)*Ri^2*Re^2     ) / ( E*(Re^2-Ri^2) )

    analyticValRi = A*Ri + B/Ri

    return analyticValRi
end