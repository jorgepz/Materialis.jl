module Materialis

  # dependencies
  include("init.jl")

  # interface
  include("interface.jl")

  include("gridOperations.jl")
  include("interpolationFuns.jl")

  include("core/generate_data.jl")
  include("core/compute_disps.jl")
  include("core/identification.jl")

  include("IO/vtkOutput.jl")
  include("IO/vtkInput.jl")

  # exports
  include("exports.jl")

end # module
