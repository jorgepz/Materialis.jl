
function ring_disps( point, E, params )

    Ri, Re, lz, nu, p = params[2:end]
    x, y, z           = point

    r = norm( point )
    
    A = ( p * (1+nu)*(1-2*nu)*Ri^2 ) / ( E*(Re^2-Ri^2) )
    B = ( p * (1+nu)*Ri^2*Re^2     ) / ( E*(Re^2-Ri^2) )
    
    ur = A*Ri + B/Ri

    u  = ur * ( point / r )

    return u
end