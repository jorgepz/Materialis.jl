"""
    AbstractMeasuredData
Abstract supertype that holds the measured data information.
"""
abstract type AbstractMeasuredData end


"""
    AbstractImage

Abstract supertype that holds the image information.
"""
abstract type AbstractImage end
"""
    AbstractGrid

Abstract supertype that holds the space grid information.
"""
abstract type AbstractGrid end
"""
    AbstractTime

Abstract supertype that holds the time information of an image.
"""
abstract type AbstractTime end

"""
    ImageData{Img<:AbstractImage, VecImg<:AbstractVector{Img}, Grid<:AbstractGrid}

### Fields

- `images` -- measured images
- `grid`   -- grid of the images
- `time`   -- image time 
"""
struct ImageData{Img<:AbstractImage, VecImg<:AbstractVector{Img}, Grid<:AbstractGrid, TimeImage<:AbstractTime}
    images::VecImg
    grid::Grid
    time::TimeImage
end

"""
    Point{T<:Real}
- `x` -- coord x of the point 
- `y` -- coord y of the point
- `z` -- coord z of the point  
"""
struct Point{T<:Real}
    x::T
    y::T
    z::T
end
"""
    StructuredGrid <:AbstractGrid

### Fields

- `num_vox`     -- vector containing the number of voxels in each direction
- `origin_vox`  -- origin point coordinates of the image
- `end_vox`     -- end point coordinates of the image 
- `dim_vox`     -- voxel dimensions  
"""
struct StructuredGrid <:AbstractGrid
    num_vox::Vector{Integer}
    origin_vox::Point
    end_vox::Point
    dim_vox
end

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