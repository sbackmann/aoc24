grid = only.(permutedims(hcat(split.(readlines("data/15.txt")[1:50], "")...)))
instructions = only.(vcat(split.(readlines("data/15.txt")[52:end], "")...))
function simulate_grid(grid, instructions)
    position = findfirst(isequal('@'), grid)
    for instruction ∈ instructions
        position = simulate_one_step(grid, instruction, position)
    end
    coordinates = 0
    for i in CartesianIndices(grid)
        if grid[i] == 'O'
            coordinates += (i[1] - 1) * 100 + i[2] - 1
        end
    end
    return coordinates
end

function simulate_one_step(grid, instruction, position)
    directions = Dict('<' => CartesianIndex(0, -1), '^' => CartesianIndex(-1, 0), '>' => CartesianIndex(0, 1), 'v' => CartesianIndex(1, 0))
    direction = directions[instruction]
    valid = true
    pos_next = position
    num_objects = 0
    while true
        pos_next += direction
        if grid[pos_next] == '.'
            break
        elseif grid[pos_next] == '#'
            valid = false
            break
        else
            num_objects += 1
        end
    end
    if valid
        grid[position + (num_objects + 1) * direction] = 'O'
        grid[position] = '.'
        position += direction
        grid[position] = '@'
    end
    return position
end

@time simulate_grid(grid, instructions)