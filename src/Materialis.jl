module Materialis

  # dependencies
  include("init.jl")

  struct gridData
    voxelsX::Int
    voxelsY::Int
    voxelsZ::Int
    gridMinX::Float64
    gridMaxX::Float64
    gridMinY::Float64
    gridMaxY::Float64
    gridMinZ::Float64
    gridMaxZ::Float64
  end

  struct ROIData
    MinX::Float64
    MaxX::Float64
    MinY::Float64
    MaxY::Float64
    MinZ::Float64
    MaxZ::Float64
  end

  # exports
  include("exports.jl")

end # module
