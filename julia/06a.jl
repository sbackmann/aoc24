module SixA

export get_positions

function get_positions(grid)
    directions = [CartesianIndex(-1, 0), CartesianIndex(0, 1), CartesianIndex(1, 0), CartesianIndex(0, -1)]
    current = findfirst(isequal('^'), grid)
    dims = size(grid)
    direction = 1
    visited = Set([current])
    while all(2 <= current[i] <= dims[i]-1 for i in 1:length(dims))
        next = grid[current + directions[direction]]
        if next == '#'
            direction = direction % 4 + 1
        else
            current += directions[direction]
            push!(visited, current)
        end 
    end
    return visited
end
lines = split.(readlines("data/06.txt"), "")
grid = only.(permutedims(hcat(lines...)))


@time println(length(get_positions(grid)))

end