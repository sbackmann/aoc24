lines = split.(readlines("data/17.txt"), ": ")
a = parse.(Int, lines[1][2])
b = parse.(Int, lines[2][2])
c = parse.(Int, lines[3][2])
prog = parse.(Int, split(lines[5][2], ","))

function simulate_program(prog, a, b, c)
    ic = 1
    output = ""
    while ic <= length(prog)
        ic, output, a, b, c = simulate_step(prog, ic, output, a, b, c)
    end
    return output
end

function simulate_step(prog, ic, output, a, b, c)
    combos = Dict(
        0 => 0, 1 => 1, 2 => 2, 3 => 3,
        4 => a,
        5 => b,
        6 => c
    )
    ops = Dict(
        0 => (x) -> a = a ÷ 2^combos[x],
        1 => (x) -> b = x ⊻ b,
        2 => (x) -> b = combos[x] % 8,
        3 => (x) -> ic = a == 0 ? ic : x - 1,
        4 => (x) -> b = b ⊻ c,
        5 => (x) -> (output *= output == "" ? "" : ","; output *= string(combos[x] % 8)),
        6 => (x) -> b = a ÷ 2^combos[x],
        7 => (x) -> c = a ÷ 2^combos[x],
    )
    i = prog[ic]
    op = prog[ic + 1]
    ops[i](op)
    ic += 2
    return ic, output, a, b, c
end

@time simulate_program(prog, a, b, c)
