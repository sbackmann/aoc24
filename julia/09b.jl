line = parse.(Int, collect(split.(readline("data/09.txt"), "")))

function get_checksum(line)
    start_indices = prepend!(accumulate(+, line) .+ 1, 1)[1:end-1]
    ids = reverse(0:((length(line)+1) ÷ 2)-1)
    nums = (reverse(line[1:2:end]), reverse(start_indices[1:2:end]), ids)
    spaces = (line[2:2:end], start_indices[2:2:end])
    expanded = zeros(start_indices[end] + line[end] -1)
    result = 0
    for i in 1:length(nums[1])
        write_idx = nums[2][i]-1
        for j in 1:length(spaces[1])
            if nums[1][i] <= spaces[1][j]
                if spaces[2][j] < nums[2][i]
                    write_idx = spaces[2][j]-1
                    spaces[2][j] += nums[1][i]
                    spaces[1][j] -= nums[1][i]
                    break
                end
            end
        end
        result += sum(collect(write_idx:write_idx+nums[1][i]-1) .* nums[3][i])
    end
    return result
end

@time get_checksum(line)