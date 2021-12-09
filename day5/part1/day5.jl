function main()
    matrix = zeros(Int,0,0)

    f = open("day5/part1/input.txt","r")

    line = readline(f,keep=false)
    while (line !== "")
        (p1,p2) = split(line, " -> ")
        (p1x,p1y) = map(x -> parse(Int,x)+1, split(p1,","))
        (p2x,p2y) = map(x -> parse(Int,x)+1, split(p2,","))

        maxy = max(p1y,p2y)
        maxx = max(p1x,p2x)

        (rows,cols) = size(matrix)
        if (rows < maxy)
            new = zeros(Int,maxy-rows,cols)
            matrix = vcat(matrix,new)
            (rows,cols) = size(matrix)
        end

        if (cols < maxx)
            new = zeros(Int,rows,maxx-cols)
            matrix = hcat(matrix,new)
        end

        if (p1x == p2x)
            if (p1y < p2y)
                matrix[p1y:p2y,p1x:p2x] .+= 1
            else
                matrix[p2y:p1y,p1x:p2x] .+= 1
            end
        elseif (p1y == p2y)
            if (p1x < p2x)
                matrix[p1y:p2y,p1x:p2x] .+= 1
            else
                matrix[p1y:p2y,p2x:p1x] .+= 1
            end
        end

        line = readline(f,keep=false)
    end

    #display(matrix)
    println()
    println(sum(matrix .>= 2))
end

readinput()