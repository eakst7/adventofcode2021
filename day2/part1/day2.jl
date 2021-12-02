using DelimitedFiles

function locator(input)::NamedTuple{(:horiz, :depth), Tuple{Int, Int}}
    horiz = 0
    depth = 0

    for row in eachrow(input)
        (direction,magnitude) = row

        if direction == "forward"
            horiz += magnitude
        elseif direction == "up"
            depth -= magnitude
        elseif direction == "down"
            depth += magnitude
        end
    end

    return (horiz = horiz, depth = depth)
end

input = readdlm("day2/part1/input.txt")

t = locator(input)

println("Horizontal: $(t[:horiz])")
println("Depth: $(t[:depth])")

println("Ans: $(t[:horiz] * t[:depth])")
