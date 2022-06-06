module Materialis

  # dependencies
  include("init.jl")
  
  include("interface.jl")

  include("gridOperations.jl")
  include("interpolationFuns.jl")
  include("vtkOutput.jl")

  # exports
  include("exports.jl")

end # module
