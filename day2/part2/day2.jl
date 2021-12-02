using DelimitedFiles

function locator(input)::NamedTuple{(:horiz, :depth), Tuple{Int, Int}}
    aim = 0
    horiz = 0
    depth = 0

    for row in eachrow(input)
        (direction,magnitude) = row

        if direction == "forward"
            horiz += magnitude
            depth += aim * magnitude
        elseif direction == "up"
            aim -= magnitude
        elseif direction == "down"
            aim += magnitude
        end
    end

    return (horiz = horiz, depth = depth)
end

input = readdlm("day2/part2/input.txt")

t = locator(input)

println("Horizontal: $(t[:horiz])")
println("Depth: $(t[:depth])")

println("Ans: $(t[:horiz] * t[:depth])")
