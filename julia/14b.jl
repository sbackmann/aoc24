using DelimitedFiles

lines = map(line -> [parse.(Int, split(res.captures[1], ",")) for res in eachmatch(r"(-?\d+,-?\d+)", line)], readlines("data/14.txt"))
positions = getindex.(lines, 1)
directions = getindex.(lines, 2)

function simulate_grid(positions, directions, iters)
    prod = 1
    end_positions = [mod.((positions[i] .+ iters * directions[i]), [101, 103]) for i in 1:length(positions)]
    for range in [[(0, 49), (0, 50)], [(51, 100), (0, 50)], [(0, 49), (52, 102)], [(51, 100), (52, 102)]]
        quad = filter(end_position -> all([range[i][1] <= end_position[i] <= range[i][2] for i in 1:2]), end_positions)
        prod *= length(quad)
    end
    grid = fill(' ', (101, 103))
    for i in end_positions
        grid[i[1]+1, i[2]+1] = '|'
    end
    for i in 1:101
        grid[i, 1] = '.'
    end
    writedlm("data/output/$iters.txt", grid)
end

function solve_leq()
    for i in 1:1000
        if isapprox(103 * i / 101 + 54/101, round(103 * i / 101 + 54/101); atol=0.000001)
            return (87 + 103 * i)
        end
    end
end
iters = solve_leq()
simulate_grid(positions, directions, iters)