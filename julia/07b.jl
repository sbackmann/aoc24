lines = split.(readlines("data/07.txt"), ": ")
lines = [parse.(Int, vcat(split.(line)...)) for line in lines]

function get_calibration_num(lines)
    total = 0
    for line in lines
        for count in 0:3^(length(line)-2)-1
            bin = digits(count, base=3, pad=length(line)-2)
            result = line[2]
            for i in 3:length(line)
                check = bin[i-2]
                num = line[i]
                if check == 0
                    result *= num
                elseif check == 1
                    result += num
                else
                    result = result * 10^(floor(Int, log10(num)) + 1) + num
                end
                if result > line[1]
                    break
                end
            end
            if result == line[1]
                total += result
                break
            end
        end
    end
    return total
end

function get_calibration_num_recursive(lines)
    result = 0
    for line in lines
        total = line[2]
        for func in [*, +, (x, y) -> x * 10^(floor(Int, log10(y)) + 1) + y]
            if operator_recursive(total, 3, line, func)
                result += line[1]
                break
            end
        end
    end
    return result
end

function operator_recursive(total, index, line, func)
    total > line[1] && return false
    total = func(total, line[index])
    if index == length(line)
        if total == line[1]
            return true
        else
            return false
        end
    end
    for func in [*, +, (x, y) -> x * 10^(floor(Int, log10(y)) + 1) + y]
        operator_recursive(total, index + 1, line, func) && return true
    end
    return false
end

@time get_calibration_num_recursive(lines)

# slower because it doesn't cut paths efficiently
@time get_calibration_num(lines)