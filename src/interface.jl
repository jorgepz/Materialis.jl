
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

function createGrid( minPoint, maxPoint, voxelNums )

    @assert sum( minPoint .<= maxPoint ) == 3

    ### MODIFY USING MULTIPLE DISPATCH ###
    if length( voxelNums ) == 1
        voxelNums = voxelNums * ones(3)
    end
    # ----------------------------------
    
    voxelWidths   = ( maxPoint - minPoint ) ./ voxelNums
    startVox      =   minPoint + voxelWidths * 0.5               
    endVox        =   maxPoint - voxelWidths * 0.5           

    return GridData( voxelNums, startVox, voxelWidths, endVox )
end