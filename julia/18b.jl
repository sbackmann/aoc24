using DataStructures

bytes = [parse.(Int, line) .+ 1 for line in split.(readlines("data/18.txt"), ",")]

function binary_search_path(bytes)
    start = 1
    last = length(bytes)
    while last - start > 1
        last_block = (start + last) ÷ 2
        grid = fill('.', (71, 71))
        for byte in bytes[1:last_block]
            grid[byte[2], byte[1]] = '#'
        end
        result = bfs(grid, CartesianIndex(1, 1), CartesianIndex(71, 71))
        if result
            start = last_block
        else
            last = last_block
        end
    end
    return bytes[last] .- 1
end

function bfs(grid, start, target)
    directions = [CartesianIndex(-1, 0), CartesianIndex(0, 1), CartesianIndex(1, 0), CartesianIndex(0, -1)]
    done = Set([])
    dist = 0
    q = PriorityQueue() 
    enqueue!(q, start, dist)
    current = start
    while !isempty(q) && current != target
        current, dist = peek(q)
        dequeue!(q)
        push!(done, current)
        for direction ∈ directions
            next = current + direction
            checkbounds(Bool, grid, next) && grid[next] == '.' && next ∉ done && next ∉ keys(q) && enqueue!(q, next, dist + 1)
        end
    end
    if current == target return true else return false end
end

@time binary_search_path(bytes)