grid = parse.(Int, permutedims(hcat(split.(readlines("data/10.txt"), "")...)))

function trailheads(grid)
    sum = 0
    for i in CartesianIndices(grid)
        if grid[i] == 0
            trailheads = find_trailheads_recursive(grid, i, 0)
            sum += trailheads
        end
    end
    return sum
end

function find_trailheads_recursive(grid, pos, current)
    directions = [CartesianIndex(-1, 0), CartesianIndex(0, 1), CartesianIndex(1, 0), CartesianIndex(0, -1)]
    if current == 9
        return 1
    end
    trailheads = 0
    for direction in directions
        pos_new = pos + direction
        if checkbounds(Bool, grid, pos_new) && grid[pos_new] == current + 1
            trailheads += find_trailheads_recursive(grid, pos_new, current + 1)
        end
    end
    return trailheads
end

@time trailheads(grid)