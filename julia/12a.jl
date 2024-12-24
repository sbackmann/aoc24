grid = only.(permutedims(hcat(split.(readlines("data/12.txt"), "")...)))

function compute_cost(grid)
    areas = []
    perimeters = []
    visited = Set([])
    for i in CartesianIndices(grid)
        if i ∈ visited
            continue
        else
            area, perimeter = greedy_search(grid, visited, i)
            push!(areas, area)
            push!(perimeters, perimeter)
        end
    end
    result = sum(areas .* perimeters)
    return result
end

function greedy_search(grid, visited, i)
    area = 1
    perimeter = 0
    push!(visited, i)
    directions = [CartesianIndex(-1, 0), CartesianIndex(0, 1), CartesianIndex(1, 0), CartesianIndex(0, -1)]
    for direction ∈ directions
        pos_new = i + direction
        if checkbounds(Bool, grid, pos_new) && grid[pos_new] == grid[i]
            if pos_new ∉ visited
                area_tmp, perimeter_tmp = greedy_search(grid, visited, pos_new)
                area += area_tmp
                perimeter += perimeter_tmp
            end
        else
            perimeter += 1
        end
    end
    return area, perimeter
end

@time compute_cost(grid)