using DataStructures
grid = only.(permutedims(hcat(split.(readlines("data/16.txt"), "")...)))

function lowest_score(grid)
    start = findfirst(isequal('S'), grid)
    lowest_score = Inf
    current_score = 0
    direction = CartesianIndex(0, 1)
    q = PriorityQueue()
    enqueue!(q, start, 0)
    direction_positions = fill(CartesianIndex(0,0), size(grid))
    direction_positions[start] = CartesianIndex(0, 1)
    for pos in CartesianIndices(grid)
        if grid[pos] ∈ ['.', 'E']
            enqueue!(q, pos, Inf)
        end
    end
    return find_path_dijkstra(grid, q, direction_positions)
end

function find_path_dijkstra(grid, q, direction_positions)
    current, score = peek(q)
    while !isempty(q) && grid[current] != 'E'
        current, score = peek(q)
        old_direction = direction_positions[current]
        dequeue!(q)
        directions = [CartesianIndex(-1, 0), CartesianIndex(0, 1), CartesianIndex(0, -1), CartesianIndex(1, 0)]
        for direction ∈ directions
            new_score = score
            next = current + direction
            if direction == old_direction
                new_score += 1
            elseif direction + old_direction == CartesianIndex(0, 0)
                new_score += 2001
            else
                new_score += 1001
            end
            if grid[next] ∈ ['.', 'E']
                new_score < get(q, next, 0) && (q[next] = new_score; direction_positions[next] = direction)
            end
        end
    end
    return score
end

@time lowest_score(grid)