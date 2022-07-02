"""
function used to read image files. All images are assumed to share the same grid.
"""

function read_vtk_grid_data( imageFilenames )



    # get grid data from first image
    vtk = VTKFile( imageFilenames[1] )
    startVox    = get_origin(vtk)
    voxelWidths = get_spacing(vtk)
    voxelNums   = ReadVTK.get_whole_extent(vtk)[2:2:end] .+ 1
    endVox      = startVox .+ ( (voxelNums .-1) .* voxelWidths )
    
    # store grid data
    grid = GridData( voxelNums, startVox, voxelWidths, endVox )

    intensities = []
    for filename in imageFilenames
        vtk = VTKFile( filename )
        point_data_raw = get_data( get_point_data(vtk)["intensity"] )
        point_data_reshaped = reshape( point_data_raw, Tuple( x for x in voxelNums) )
        push!(intensities, point_data_reshaped)
    end

    return grid, intensities
end