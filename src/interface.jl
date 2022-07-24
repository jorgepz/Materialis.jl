"""
    AbstractMeasuredData
Abstract supertype that holds the measured data information.
"""
abstract type AbstractMeasuredData end


struct GridData
    voxelNums::Vector{Int}
    startVox::Vector{Float64}
    voxelWidths::Vector{Float64}
    endVox::Vector{Float64}
end

struct ROIData
    Mins::Vector{Float64}
    Maxs::Vector{Float64}
end

function create_grid( minPoint, maxPoint, voxelNums )

    space_dim = length(minPoint)

    sum( minPoint .<= maxPoint ) != space_dim && error("origin must be lower that end")

    ### MODIFY USING MULTIPLE DISPATCH ###
    if length( voxelNums ) == 1
        voxelNums = voxelNums * ones( space_dim )
    end
    # ----------------------------------
    
    voxelWidths   = ( maxPoint - minPoint ) ./ voxelNums
    startVox      =   minPoint + voxelWidths * 0.5               
    endVox        =   maxPoint - voxelWidths * 0.5           

    return GridData( voxelNums, startVox, voxelWidths, endVox )
end


mutable struct SolidSolverParams
    solver_type::String
    params::Vector
end