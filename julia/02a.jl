lines = [parse.(Int, arr) for arr in split.(readlines("data/02.txt"))]

function get_num_safe(nums)
    safe = 0
    for line in lines
        if length(line) == 1
            safe += 1
        else
            increasing = line[1] - line[2] < 0
            old = line[1]
            valid = true
            for num in line[2:end]
                if 1 <= num - old <= 3 && increasing || 1 <= old - num <= 3 && !increasing
                    old = num
                else
                    valid = false
                    break
                end
            end
            safe += valid ? 1 : 0
        end
    end
    return safe
end

println(get_num_safe(lines))