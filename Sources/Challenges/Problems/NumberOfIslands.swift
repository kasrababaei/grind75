/*
 [Source](https://leetcode.com/problems/number-of-islands/description/)
 */

enum NumberOfIslands {
  final class Solution {
    func numIslands(_ grid: [[Character]]) -> Int {
      var grid = grid
      let moves = [(0, -1), (-1, 0), (0, 1), (1, 0)]
      let maxX = grid.count - 1
      let maxY = grid[0].count - 1
      var queue: [Location] = []
      var count = 0
      
      for x in 0...maxX {
        for y in 0...maxY {
          guard grid[x][y] == "1" else {
            continue
          }
          
          queue.append(Location(x: x, y: y))
          
          while queue.isEmpty == false {
            let current = queue.removeFirst()
            grid[current.x][current.y] = "0"
            
            for move in moves {
              let next = Location(x: current.x + move.0, y: current.y + move.1)
              guard (0...maxX) ~= next.x, (0...maxY) ~= next.y else { continue }
              guard grid[next.x][next.y] == "1" else { continue }
              grid[next.x][next.y] = "0"
              queue.append(next)
            }
          }
          
          count += 1
        }
      }
      
      return count
    }
  }
  
  struct Location: Hashable {
    var x: Int
    var y: Int
  }
}
