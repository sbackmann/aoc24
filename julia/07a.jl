lines = split.(readlines("data/07.txt"), ": ")
lines = [parse.(Int, vcat(split.(line)...)) for line in lines]

function get_calibration_num(lines)
    total = 0
    for line in lines
        for count in 0:2^(length(line)-2)-1
            bin = digits(count, base=2, pad=length(line)-2)
            result = line[2]
            for i in 3:length(line)
                result = result * max(1, (1 - bin[i-2]) * line[i]) + bin[i-2] * line[i]
            end
            if result == line[1]
                total += result
                break
            end
        end
    end
    return total
end

@time get_calibration_num(lines)