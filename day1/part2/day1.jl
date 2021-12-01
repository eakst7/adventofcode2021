using DelimitedFiles

function rollingsum(input, index)::Int
    input[index] + input[index+1] + input[index+2]
end

function increasingdepths(input)::Int
    increasingcount = 0

    lastval = rollingsum(input, 1)
    println("$lastval (no previous sum)")
    for i in 2:(length(input) - 2)
        rsum = rollingsum(input, i)

        if rsum > lastval
            println("$i $rsum (increased)")
            increasingcount += 1
        elseif rsum < lastval
            println("$i $rsum (decreased)")
        else
            println("$i $rsum (no change)")
        end

        lastval = rsum
    end

    return increasingcount
end

input = readdlm("day1/part2/input.txt", Int)

println(increasingdepths(input))
