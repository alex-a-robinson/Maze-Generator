#!/usr/bin/env ruby

/*

Maze generator in Ruby!

ToDo:
    - Check algorithm
    - Draw maze

Extensions:
    - More algorithms
    - Solving maze
*/

Unvisited = 0
Visited = 1

class RecursiveBacktracker
	
    def initialize(width=10, height=10, start=0)
        @width, @height = width, height
        @grid = Array.new(width * height, Unvisited)
        @currentCell = start
        @stack = []
    end
    
    def rowOf(index)
        # Returns the grid row an index lies in
        return index / @width
    end
    
    def colOf(index)
        # Returns the grid column which an index lies in
        return index % @height
    end
    
    def ingrid?(index)
        # Determines if an index is in the grid or not
        return (index >= 0 and index < @grid.length)? true : false
    end
    
    def visited?(index)
        # Determines if an index has been visited 
        return (@grid[index] == Visited)? true : false
    end
    
    def visited!(index)
        # Sets an index to visted
        @grid[index] = Visited
    end
    
    def randCell
        # Returns a random index from the grid
        return Random.rand(@grid.length - 1)
    end
    
    def getNeighbours
        # Returns a list of unvisited neighbouring cells
        neighbours = []     
                        
        if ((rowOf (index = (@currentCell + 1))) == (rowOf @currentCell)) and ingrid? index and not visited? index then neighbours.push(index) end
        if ((rowOf (index = (@currentCell - 1))) == (rowOf @currentCell ))and ingrid? index and not visited? index then neighbours.push(index) end
        if ((colOf (index = (@currentCell + @width))) == (colOf @currentCell)) and ingrid? index and not visited? index then neighbours.push(index) end
        if ((colOf (index = (@currentCell - @width))) == (colOf @currentCell)) and ingrid? index and not visited? index then neighbours.push(index) end
        
        return neighbours
    end
    
    def generate
        # Generates the complete maze
        
        @grid[@currentCell] = Visited
        while @grid.include? Unvisited        
        
            if  (neighbours = getNeighbours).length > 0
            
                @stack.push(@currentcell)
            
                index = Random.rand(neighbours.length)
                @currentCell = neighbours[index]
                visited! @currentCell
            elsif @stack.length > 0
                @stack.pop
                @currentCell = @stack.length - 1
            else
                index = randCell
                while not visited? index and ingrid? index
                    index = randCell
                end
                
                @currentCell = index
                visited! @currentCell
            end
        end
    end
    
    def render
        print "-" * 5 + " Maze " + "-" * 5
        @grid.each_with_index do |cell, index|
            if index % @width == 0 then puts "\n" end
            if @stack.index cell > 0 then print "X" else print "." end
        end
        print "\n" + "-" * 16 + "\n"
    end
end

maze = RecursiveBacktracker.new()
maze.generate
maze.render
