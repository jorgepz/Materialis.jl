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
      ROIMinX::Float64
      ROIMaxX::Float64
      ROIMinY::Float64
      ROIMaxY::Float64
      ROIMinZ::Float64
      ROIMaxZ::Float64
  end

  # exports
  include("exports.jl")

end # module
