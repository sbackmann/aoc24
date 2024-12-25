grid = only.(permutedims(hcat(split.(readlines("data/15.txt")[1:50], "")...)))
instructions = only.(vcat(split.(readlines("data/15.txt")[52:end], "")...))

function simulate_grid(grid, instructions)
    grid_new = fill('.', (size(grid)[1], size(grid)[2] * 2))
    for i in CartesianIndices(grid)
        if grid[i] == '#'
            grid_new[i[1], 2*i[2]-1] = '#'
            grid_new[i[1], 2*i[2]] = '#'
        elseif grid[i] == 'O'
            grid_new[i[1], 2*i[2]-1] = '['
            grid_new[i[1], 2*i[2]] = ']'
        elseif grid[i] == '@'
            grid_new[i[1], 2*i[2]-1] = '@'
        end
    end
    position = findfirst(isequal('@'), grid_new)
    for instruction ∈ instructions
        position = simulate_one_step(grid_new, instruction, position)
    end
    coordinates = 0
    for i in CartesianIndices(grid_new)
        if grid_new[i] == '['
            coordinates += (i[1] - 1) * 100 + i[2] - 1
        end
    end
    return coordinates
end

function simulate_one_step(grid, instruction, position)
    directions = Dict('<' => CartesianIndex(0, -1), '^' => CartesianIndex(-1, 0), '>' => CartesianIndex(0, 1), 'v' => CartesianIndex(1, 0))
    direction = directions[instruction]
    valid = true
    queue = [position + direction]
    affected_positions = [position]
    new_positions = [(position + direction, '@')]
    while length(queue) != 0
        pos_next = popfirst!(queue)
        if instruction ∈ ['<', '>']
            if grid[pos_next] ∈ ['[', ']']
                push!(new_positions, (pos_next + direction, grid[pos_next]))
                push!(queue, pos_next + direction)
            end
        elseif instruction ∈ ['^', 'v']
            if grid[pos_next] == '['
                push!(queue, pos_next + direction)
                push!(queue, pos_next + direction + CartesianIndex(0, 1))
                push!(affected_positions, pos_next + CartesianIndex(0, 1))
                push!(new_positions, (pos_next + direction, '['))
                push!(new_positions, (pos_next + direction + CartesianIndex(0, 1), ']'))
            elseif grid[pos_next] == ']'
                push!(queue, pos_next + direction)
                push!(queue, pos_next + direction + CartesianIndex(0, -1))
                push!(affected_positions, pos_next + CartesianIndex(0, -1))
                push!(new_positions, (pos_next + direction, ']'))
                push!(new_positions, (pos_next + direction + CartesianIndex(0, -1), '['))
            end
        end
        if grid[pos_next] == '#'
            valid = false
            break
        end
    end
    if valid
        for position in affected_positions
            grid[position] = '.'
        end
        for (position, new) in new_positions
            grid[position] = new
        end
        position += direction
    end
    return position
end

@time simulate_grid(grid, instructions)