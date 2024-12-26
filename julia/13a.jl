lines = map(line -> [parse(Int, (match.captures[1])) for match in eachmatch(r"(\d+)(?:$|,)", line)], readlines("data/13.txt"))
function prizes(lines)
    prizes = 0
    costs = 0
    for i in 1:4:length(lines)
        leq_matrix = hcat(lines[i], lines[i+1])
        solved = leq_matrix \ lines[i+2]
        if all([solve ≈ round(solve) for solve in solved])
            prizes += 1
            costs += sum(round.(solved) .* [3, 1])
        end
    end
    return prizes, costs
end

@time prizes(lines)