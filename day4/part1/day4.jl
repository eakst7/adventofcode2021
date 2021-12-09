board = [
    14 21 17 24  4
    10 16 15  9 19
    18  8 23 26 20
    22 11 13  6  5
     2  0 12  3  7
]

marked = BitArray(undef, 5,5)

for i in eachindex(board)
    if board[i] in [14,21,17,24,4,9,23,11,5,2,0,7]
        marked[i] = true
    end
end

function markboard(num::Int, b::NamedTuple{(:board, :marked), Tuple{Array, Array}})
    for i in eachindex(board)
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

    score = -1
    for d in draws
        println("Drawing $d")
        for b in boards
            markboard(d,b)
            if checkboard(b)
                score = d * scoreboard(b)
                @goto done
            end
        end
    end

    @label done 
    print("Score is $score")
end

main()


# display(board)
# println()
# display(marked)
# println()

# println(checkboard(marked))
# println(scoreboard(board,marked))
