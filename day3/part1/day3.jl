using DelimitedFiles

function enginepower(input)::Int 
    bitstrlength = length(input[1])

    inputmatrix = Array{Char}(undef,0,bitstrlength)

    for i in input
        inputmatrix = vcat(inputmatrix,reshape(collect(i),1,bitstrlength))
    end

    gamma = 0
    epsilon = 0

    for i in 1:bitstrlength
        gamma = gamma << 1
        epsilon = epsilon << 1

        onebits = count(x -> x == '1', inputmatrix[:,i])
        zerobits = count(x -> x == '0', inputmatrix[:,i])

        if onebits > zerobits
            gamma = gamma | 1
        elseif zerobits > onebits
            epsilon = epsilon | 1
        else
            throw(Error("error"))
        end
    end

    power = gamma * epsilon

    println("gamma = $gamma")
    println("epsilon = $epsilon")
    println("power = $(power)")

    return power
end


input = readdlm("day3/part1/input.txt",String)

enginepower(input)
