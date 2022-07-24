
function ring_disps( E, params )

    r1, r2, lz, nu, p = params[2:end]

    Ri = r1
    Re = r2
    
    A = ( p * (1+nu)*(1-2*nu)*Ri^2 ) / ( E*(Re^2-Ri^2) )
    B = ( p * (1+nu)*Ri^2*Re^2     ) / ( E*(Re^2-Ri^2) )

    return A*Ri + B/Ri
end