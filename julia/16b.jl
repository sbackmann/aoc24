using DataStructures
grid = only.(permutedims(hcat(split.(readlines("data/16_test.txt"), "")...)))

function lowest_score(grid)
    start = findfirst(isequal('S'), grid)
    lowest_score = Inf
    q = PriorityQueue()
    enqueue!(q, (start, CartesianIndex(0, 1)) , 0)
    direction_positions = fill(CartesianIndex(0,0), size(grid))
    direction_positions[start] = CartesianIndex(0, 1)
    directions = [CartesianIndex(-1, 0), CartesianIndex(0, 1), CartesianIndex(0, -1), CartesianIndex(1, 0)]
    for pos in CartesianIndices(grid)
        if grid[pos] ∈ ['.', 'E']
            for direction in directions
                enqueue!(q, (pos, direction), Inf)
            end
        end
    end
    preds, current, direction = find_path_dijkstra(grid, q)
    all_nodes = Set([])
    all_nodes_directions = Set([])
    q = Set([(current, direction)])
    while !isempty(q)
        (current, direction) = pop!(q)
        push!(all_nodes, current)
        push!(all_nodes_directions, (current, direction))
        for (pred, pred_dir) ∈ preds[(current, direction)]
            (pred, pred_dir) ∉ all_nodes_directions && push!(q, (pred, pred_dir))
        end
    end
    return all_nodes
end

function find_path_dijkstra(grid, q)
    (current, old_direction), score = peek(q)
    preds = Dict((current, old_direction) => Set([]))
    distances = Dict((current, old_direction) => score)
    while !isempty(q) && grid[current] != 'E'
        (current, old_direction), score = peek(q)
        dequeue!(q)
        directions = [CartesianIndex(-1, 0), CartesianIndex(0, 1), CartesianIndex(0, -1), CartesianIndex(1, 0)]
        for direction ∈ directions
            new_score = score
            if direction + old_direction == CartesianIndex(0, 0)
                new_score += 2000
            elseif direction != old_direction
                new_score += 1000
            end
            if new_score < get(distances, (current, direction), Inf) && direction != old_direction
                distances[(current, direction)] = new_score
                q[(current, direction)] = new_score
                preds[(current, direction)] = Set([(current, old_direction)])
            elseif new_score == get(distances, (current, direction), Inf) && direction != old_direction
                push!(preds[(current, direction)], (current, old_direction))
            end
            next = current + direction
            new_score += 1
            if grid[next] ∈ ['.', 'E']
                if new_score < get(distances, (next, direction), Inf)
                    distances[(next, direction)] = new_score
                    q[(next, direction)] = new_score
                    preds[(next, direction)] = Set([(current, old_direction)])
                elseif new_score == get(distances, (next, direction), Inf)
                    push!(preds[(next, direction)], (current, old_direction))
                end
            end
        end
    end
    return preds, current, old_direction
end

@time lowest_score(grid)