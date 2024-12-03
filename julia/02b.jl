lines = [parse.(Int, line) for line in split.(readlines("data/02.txt"))]

function get_num_safe(nums)
    safe = 0
    for line in nums
        diffs = @views line[2:end] .- line[1:end-1]
        if all(i -> 1 <= i <= 3, diffs) || all(i -> -3 <= i <= -1, diffs)
            safe += 1
        else
            violations = findall(x -> x > 3 || x < 1, diffs)
            increasing = true
            if length(violations) >= length(line)-2
                violations = findall(x -> x < -3 || x > -1, diffs)
                increasing = false
            end
            if length(violations) == 1
                violation = violations[1]
                if violation == 1 || violation == length(diffs)
                    safe += 1
                elseif increasing && (1 <= line[violation+2]-line[violation] <= 3 || 1 <= line[violation+1]-line[violation-1] <= 3) || !increasing && (-3 <= line[violation+2]-line[violation] <= -1 || -3 <= line[violation+1]-line[violation-1] <= -1)
                    safe += 1
                else
                end
            elseif length(violations) == 2
                if violations[2] - violations[1] == 1 && (increasing && 1 <= line[violations[2]+1]-line[violations[2]-1] <= 3 || !increasing && -3 <= line[violations[2]+1]-line[violations[2]-1] <= -1)
                    safe += 1
                end
            end
        end
    end
    return safe
end

print(get_num_safe(lines))