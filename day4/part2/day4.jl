function markboard(num::Int, b::NamedTuple{(:board, :marked), Tuple{Array, Array}})
    for i in eachindex(b.board)
        if b.board[i] == num
            b.marked[i] = true
        end
    end
end

function readinput()
    f = open("day4/part1/input.txt","r")
    draws = parseDraws(readline(f,keep=false))
    readline(f,keep=false)

    boards = []
    board = readboard(f)
    while board !== nothing
        display(board.board)
        println()
        push!(boards,board)
        board = readboard(f)
    end

    return (draws = draws,boards = boards)
end

function readboard(f)::Union{Nothing,NamedTuple{(:board, :marked), Tuple{Array, Array}}}
    board = []
    line = readline(f,keep=false)
    while line !== ""
        append!(board,parseBoard(line))
        line = readline(f,keep=false)
    end

    if board == []
        return nothing
    end

    (board = permutedims(reshape(board,5,5)),marked = BitArray(undef,5,5))
end

function parseBoard(s::String)::Array{Int}
    map(s -> parse(Int, s, base=10), split(s))
end

# Given a string of comma separated numbers, split
# them and parse them to an array of Ints
function parseDraws(s::String)::Array{Int}
    map(s -> parse(Int, s, base=10), split(s,","))
end

function invert(marked)
    map(!,marked)
end

function scoreboard(b::NamedTuple{(:board, :marked), Tuple{Array, Array}})::Int
    sum(b.board .* invert(b.marked))
end

function checkboard(b::NamedTuple{(:board, :marked), Tuple{Array, Array}})::Bool
    (rows,cols) = size(b.marked)
    for col in 1:cols
        if all(b.marked[:,col])
            println("col $col is winner")
            display(b.board)
            println()
            display(b.marked)
            println()
            return true
        end
    end

    for row in 1:rows
        if all(b.marked[row,:])
            println("row $row is winner")
            display(b.board)
            println()
            display(b.marked)
            println()
            return true
        end
    end
    return false
end

function main()
    (draws,boards) = readinput()
    print(typeof(boards))

    lastdeleted = nothing
    lastcall = nothing
    score = -1
    for d in draws
        println("Drawing $d")
        todelete = []
        for i in eachindex(boards)
            b = boards[i]
            markboard(d,b)
            if checkboard(b)
                push!(todelete,i)
                lastdeleted = b
                lastcall = d
            end
        end
        deleteat!(boards,todelete)
        if length(boards) == 0
            @goto done
        end
    end

    @label done 
    score = scoreboard(lastdeleted)
    print("Score is $(score * lastcall)")
end

main()
