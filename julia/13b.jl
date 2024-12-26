lines = map(line -> [parse(Int, (match.captures[1])) for match in eachmatch(r"(\d+)(?:$|,)", line)], readlines("data/13.txt"))
function prizes(lines)
    prizes = 0
    costs = 0
    for i in 1:4:length(lines)
        leq_matrix = hcat(lines[i], lines[i+1])
        solved = leq_matrix \ (lines[i+2] .+ 10000000000000)
        if all([isapprox(solve, round(solve); atol=0.0001) for solve in solved])
            @printf "%f %f\n" solved[1] solved[2]
            prizes += 1
            costs += sum(round.(solved) .* [3, 1])
        end
    end
    return costs
end

using Printf
@time prizes(lines)