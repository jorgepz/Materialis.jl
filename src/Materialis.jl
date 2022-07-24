module Materialis

  # dependencies
  include("init.jl")
  
  include("interface.jl")

  include("gridOperations.jl")
  include("interpolationFuns.jl")
  include("core/identification.jl")
  include("core/generate_data.jl")
  include("IO/vtkOutput.jl")
  include("IO/vtkInput.jl")

  # exports
  include("exports.jl")

end # module
