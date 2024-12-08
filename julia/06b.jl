
lines = split.(readlines("data/06.txt"), "")
grid = only.(permutedims(hcat(lines...)))

function get_positions_w_directions(grid)
    directions = [CartesianIndex(-1, 0), CartesianIndex(0, 1), CartesianIndex(1, 0), CartesianIndex(0, -1)]
    start = current = findfirst(isequal('^'), grid)
    dims = size(grid)
    direction = 1
    current_set = CartesianIndex(current[1], current[2], 1)
    obstacles = Set([])
    checked = Set([])
    visited = Set([current_set])
    while all(2 <= current[i] <= dims[i]-1 for i in 1:length(dims))
        next = current + directions[direction]
        if grid[next] == '#'
            direction = direction % 4 + 1
        else
            obstacle = next
            if !(obstacle in checked) && obstacle != start
                check_obstacle(grid, current, direction) && push!(obstacles, obstacle)
                push!(checked, obstacle)
            end
            current = next
        end 
        current_set = CartesianIndex(current[1], current[2], direction)
        push!(visited, current_set)
    end
    return obstacles
end

function check_obstacle(grid, current, direction)
    new = Set([])
    dims = size(grid)
    directions = [CartesianIndex(-1, 0), CartesianIndex(0, 1), CartesianIndex(1, 0), CartesianIndex(0, -1)]
    obstacle = current + directions[direction]
    while all(2 <= current[i] <= dims[i]-1 for i in 1:length(dims))
        next = current + directions[direction]
        if grid[next] == '#' || next == obstacle
            direction = direction % 4 + 1
        else
            current = next
            current_set = CartesianIndex(current[1], current[2], direction)
            current_set in new && return true
            push!(new, current_set)
        end
    end
    return false
end

@time get_positions_w_directions(grid)