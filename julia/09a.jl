line = parse.(Int, collect(split.(readline("data/09.txt"), "")))

function get_checksum(line)
    expanded = []
    isblock = true
    for (idx, num) in enumerate(line)
        part = isblock ? repeat([idx ÷ 2], num) :  repeat([-1], num)
        append!(expanded, part)
        isblock = !isblock
    end
    idx2 = length(expanded)
    result = 0
    for (idx1, num) in enumerate(expanded)
        if idx1 > idx2
            break
        end
        if num == -1
            while idx2 > idx1 && expanded[idx2] == -1
                idx2 -= 1
            end
            if idx2 > idx1 
                result += (idx1-1) * expanded[idx2]
                idx2 -= 1
            end
        else
            result += (idx1-1) * num
        end
    end
    return result
end

@time print(get_checksum(line))