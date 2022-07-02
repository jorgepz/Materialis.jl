
function read_vtk_grid_data( imageFilenames )

#    VTKFile

    for filename in imageFilenames
        vtk = VTKFile( filename )
        print(filename)
    end

    return 1,2
end