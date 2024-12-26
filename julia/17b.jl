lines = split.(readlines("data/17.txt"), ": ")
a = parse.(Int, lines[1][2])
b = parse.(Int, lines[2][2])
c = parse.(Int, lines[3][2])
prog = parse.(Int, split(lines[5][2], ","))

function simulate_program(prog, a, b, c)
    output = []
    index = lastindex(prog) - 1
    num = 0
    while length(output) != length(prog)
        for a in 0:63
            a_copy = num << 6 + a
            ic = 1
            output = []
            while ic <= length(prog)
                ic, output, a_copy, b, c = simulate_step(prog, ic, output, a_copy, b, c)
            end
            if output == prog[index:end]
                num = num << 6 + a
                index -= 2
                break
            end
        end
    end
    return num
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
        5 => (x) -> (push!(output, combos[x] % 8)),
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
