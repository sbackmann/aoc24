grid = only.(permutedims(hcat(split.(readlines("data/08.txt"), "")...)))

function get_antinodes(grid)
    antinodes = Set([])
    antennas = Dict()
    for i in CartesianIndices(grid)
        if grid[i] != '.'
            push!(get!(antennas, grid[i], []), i)
        end
    end
    for (k, v) in pairs(antennas)
        length(v) <= 1 && continue
        union!(antinodes, get_locations(v, grid))
    end
    return antinodes
end

function get_locations(antennas, grid)
    antenna_pairs = [(x, y) for x in antennas, y in antennas if x != y]
    antinodes = Set([])
    for (a1, a2) in antenna_pairs
        diff = a1 - a2
        checkbounds(Bool, grid, a1 + diff) && push!(antinodes, a1 + diff)
        checkbounds(Bool, grid, a2 - diff) && push!(antinodes, a2 - diff)
    end
    return antinodes
end

@time get_antinodes(grid)