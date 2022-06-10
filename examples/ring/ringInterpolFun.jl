function ringInterpolFunc( nodes, rint, rext )

  nnodes = size(nodes,1)

  vals = zeros( Float64, nnodes ) 

  rval = sqrt.( sum( nodes[:,1:2].^2, dims=2 ) )

  for i in (1:nnodes)    
    if (rval[i] < rext) && (rval[i] > rint)
        vals[i] = rval[i]
    end
  end

  return vals
end