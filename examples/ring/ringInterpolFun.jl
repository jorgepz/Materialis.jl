function ringInterpolFunc( nodes, rint, rext )

  nnodes = size(nodes,1)

  vals = zeros( Float64, nnodes ) 

  for i in (1:nnodes)
    rval = sum( nodes[i,:].^2 )
    print("hola", rval,"\n")
    if (rval < rext^2) && (rval > rint^2)
        vals[i] = rval
    end
  end

  return vals

end