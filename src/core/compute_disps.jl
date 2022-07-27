"""
Function that computes the displacements and sensitivities using external user-provided tools at the points of the image grid.
"""
function compute_disps( mat_param, solver_params, grid )

    if cmp( solver_params.solver_type, "analytic")==0

        disp_func_name = solver_params.params[1]

        u, dudp = eval( Symbol( disp_func_name ) )( nodes_matrix, mat_param, solver_params.params )


    end

    return u
end
