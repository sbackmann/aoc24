line = parse.(Int, split(readline("data/11.txt")))

function num_stones(line)
    current = copy(line)
    for i in 1:25
        next_iter = []
        for elem in current
            string_elem = string(elem)
            if elem == 0
                push!(next_iter, 1)
            elseif length(string_elem) % 2 == 0
                push!(next_iter, parse(Int, string_elem[1:length(string_elem) ÷ 2]))
                push!(next_iter, parse(Int, string_elem[length(string_elem)÷2+1:end]))
            else
                push!(next_iter, elem * 2024)
            end
        end
        copy!(current, next_iter)
    end
    return length(current)
end

@time num_stones(line)