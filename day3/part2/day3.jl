using DelimitedFiles

function mostcommonbit(inputmatrix, bitpos::Int, tiebreaker::Char)::Char
    (rows,cols) = size(inputmatrix)
    onebits = count(x -> x == '1', inputmatrix[:,bitpos])
    zerobits = rows - onebits

    if onebits > zerobits
        return '1'
    elseif zerobits > onebits
        return '0'
    else
        return tiebreaker
    end
end

function o2generator(inputmatrix)::Int
    copyofmatrix = copy(inputmatrix)

    # We're going to mutate the matrix, so make a copy
    (rows,cols) = size(copyofmatrix)
    display(copyofmatrix)
    println("")

    # Iterate over each column in the matrix
    for col in 1:cols

        # Find the most common bit, with ties resolving as '1'
        mcb = mostcommonbit(copyofmatrix,col,'1')
        println("Col = $col mcb = $mcb")
    
        # Build a vector of booleans for each row.  Set the
        # row to 'true' if the most common bit matches the
        # value of the bit in the current column.
        select = Bool[]
        for row in 1:rows
            if mcb == copyofmatrix[row,col]
                push!(select, true)
            else
                push!(select,false)
            end
        end
        # display(select)
        # println("")

        # Update the working copy of the matrix by selecting the
        # rows that are true.
        copyofmatrix = copyofmatrix[select,:]
        (rows,_) = size(copyofmatrix)
        display(copyofmatrix)
        println("")

        # If we have only one row left, that's our answer.
        # Convert the bit pattern to an int and return it.
        if rows == 1
            return parse(Int, String(copyofmatrix[1,:]), base=2)
        end
    end

    throw(Error("Should never get here"))
end

function co2scrubber(inputmatrix)::Int
    copyofmatrix = copy(inputmatrix)

    # We're going to mutate the matrix, so make a copy
    (rows,cols) = size(copyofmatrix)
    display(copyofmatrix)
    println("")

    # Iterate over each column in the matrix
    for col in 1:cols

        # Find the most common bit, with ties resolving as '1'
        mcb = mostcommonbit(copyofmatrix,col,'1')
        lcb = mcb == '1' ? '0' : '1'
        println("Col = $col lcb = $lcb")
    
        # Build a vector of booleans for each row.  Set the
        # row to 'true' if the most common bit matches the
        # value of the bit in the current column.
        select = Bool[]
        for row in 1:rows
            if lcb == copyofmatrix[row,col]
                push!(select, true)
            else
                push!(select,false)
            end
        end
        # display(select)
        # println("")

        # Update the working copy of the matrix by selecting the
        # rows that are true.
        copyofmatrix = copyofmatrix[select,:]
        (rows,_) = size(copyofmatrix)
        display(copyofmatrix)
        println("")

        # If we have only one row left, that's our answer.
        # Convert the bit pattern to an int and return it.
        if rows == 1
            return parse(Int, String(copyofmatrix[1,:]), base=2)
        end
    end

    throw(Error("Should never get here"))
end

function lifesupport(input)::Int 
    bitstrlength = length(input[1])

    inputmatrix = Array{Char}(undef,0,bitstrlength)

    for i in input
        inputmatrix = vcat(inputmatrix,reshape(collect(i),1,bitstrlength))
    end

    o2 = o2generator(inputmatrix)
    co2 = co2scrubber(inputmatrix)
    lifesupport = o2 * co2

    println("o2 = $o2")
    println("co2 = $co2")

    println("lifesupport = $lifesupport")

    lifesupport
end


input = readdlm("day3/part1/input.txt",String)

lifesupport(input)
