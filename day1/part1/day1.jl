using DelimitedFiles

function increasingdepths(input)::Int
    increasingcount = 0

    lastval = input[1]
    for i in @view input[2:end]
        #println("$i $lastval")
        if i > lastval
            increasingcount += 1
        end
        lastval = i
    end

    return increasingcount
end

input = readdlm("input.txt", Int)

println(increasingdepths(input))
