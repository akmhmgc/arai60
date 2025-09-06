# step2 他の方の解答を見る
- https://github.com/shining-ai/leetcode/pull/17
- https://github.com/ichika0615/arai60/pull/9

## Union Find
Union Findを使ったことがないので解いてみる。
gridの行・列の長さをM,Nとすると時間計算量はO((MN)^2)となる。
行・列の長さの最大が3*10^2なので1秒以内だとギリギリかもしれない。
計算量を削減することでO((MN)log(MN))にする。
union by sizeを利用した。

```ruby
class UnionFind
    def initialize(nodes)
      @child_to_parent = {}
      @root_to_size = {}
      nodes.each do |node|
        @child_to_parent[node] = node
        @root_to_size[node] = 1
      end
    end

    def root(node)
      return node if @child_to_parent[node] == node

      root(@child_to_parent[node])
    end

    def unite(node_x, node_y)
      root_of_many_nodes = root(node_x)
      root_of_few_nodes = root(node_y)
      return if root_of_many_nodes == root_of_few_nodes

      if size(root_of_many_nodes) < size(root_of_few_nodes)
        root_of_many_nodes, root_of_few_nodes = root_of_few_nodes, root_of_many_nodes
      end
      @child_to_parent[root_of_few_nodes] = root_of_many_nodes
      @root_to_size[root_of_many_nodes] += @root_to_size[root_of_few_nodes]
    end
    
    private

    def size(root)
        @root_to_size[root]
    end
end


# @param {Character[][]} grid
# @return {Integer}
def num_islands(grid)
    water = "0".freeze

    row_size = grid.length
    column_size = grid.first.size
    islands = Set.new
    row_size.times do |row|
        column_size.times do |column|
            next if grid[row][column] == water

            islands << [row, column] 
        end
    end

    visited = Array.new(row_size) { |index| Array.new(column_size, false) }
    directions = [ [0, 1], [1, 0], [0, -1], [-1, 0] ]
    union_find_islands = UnionFind.new(islands)
    islands.each do |island|
        row, column = island
        directions.each do |row_offset, column_offset|
            next_row = row + row_offset
            next_column = column + column_offset
            next unless islands.include?([next_row, next_column])

            union_find_islands.unite([row, column], [next_row, next_column])
        end
    end

    result = 0
    islands.each do |island|
        next if union_find_islands.root(island) != island

        result += 1
    end
    result
end
```

UnionFindを変数に入れる時にどういう命名にしたら良いか悩んだ。
union by sizeを使っているが、上のコードでは常にサイズが小さいnodeが第2引数にくるのでswapしなくても時間内に計算が間に合う。

これでも間に合う
```ruby
class UnionFind
    def initialize(nodes)
      @child_to_parent = {}
      @root_to_size = {}
      nodes.each do |node|
        @child_to_parent[node] = node
        @root_to_size[node] = 1
      end
    end

    def root(node)
      return node if @child_to_parent[node] == node

      root(@child_to_parent[node])
    end

    def unite(node_x, node_y)
      root_of_many_nodes = root(node_x)
      root_of_few_nodes = root(node_y)
      return if root_of_many_nodes == root_of_few_nodes

    #   if size(root_of_many_nodes) < size(root_of_few_nodes)
    #     root_of_many_nodes, root_of_few_nodes = root_of_few_nodes, root_of_many_nodes
    #   end
      @child_to_parent[root_of_few_nodes] = root_of_many_nodes
      @root_to_size[root_of_many_nodes] += @root_to_size[root_of_few_nodes]
    end
    
    private

    def size(root)
        @root_to_size[root]
    end
end
```

以下のようにxとyを入れ替えると間に合わない

```ruby
class UnionFind
    def initialize(nodes)
      @child_to_parent = {}
      @root_to_size = {}
      nodes.each do |node|
        @child_to_parent[node] = node
        @root_to_size[node] = 1
      end
    end

    def root(node)
      return node if @child_to_parent[node] == node

      root(@child_to_parent[node])
    end

    def unite(node_x, node_y)
      # swap node_x and node_y
      root_of_many_nodes = root(node_y)
      root_of_few_nodes = root(node_x)
      return if root_of_many_nodes == root_of_few_nodes
      #   if size(root_of_many_nodes) < size(root_of_few_nodes)
      #     root_of_many_nodes, root_of_few_nodes = root_of_few_nodes, root_of_many_nodes
      #   end

      @child_to_parent[root_of_few_nodes] = root_of_many_nodes
      @root_to_size[root_of_many_nodes] += @root_to_size[root_of_few_nodes]
    end
    
    private

    def size(root)
        @root_to_size[root]
    end
end
```

経路圧縮だと以下のようになる。

```ruby
class UnionFind
    def initialize(nodes)
      @child_to_parent = {}
      @root_to_size = {}
      nodes.each do |node|
        @child_to_parent[node] = node
        @root_to_size[node] = 1
      end
    end

    def root(node)
      return node if @child_to_parent[node] == node

      @child_to_parent[node] = root(@child_to_parent[node])
    end

    def unite(node_x, node_y)
      root_x = root(node_y)
      root_y = root(node_x)
      return if root_x == root_y

      @child_to_parent[root_y] = root_x
      @root_to_size[root_x] += @root_to_size[root_y]
    end
    
    private

    def size(root)
        @root_to_size[root]
    end
end
```

今回はunionで追加するノードのサイズが常に1なので、union by sizeと経路圧縮の両方を使ったとしても片方だけと比較して空間計算量は改善されない。


## step1の解法の修正
step1では、次に見る場所をvisitedでチェックしてから次のループに回していて素直ではなかったので修正した。

```ruby
# @param {Character[][]} grid
# @return {Integer}
def num_islands(grid)
    water = "0".freeze

    num_islands = 0
    row_size = grid.length
    col_size = grid.first.size
    visited = Array.new(row_size) { |index| Array.new(col_size, false) }
    offsets = [ [0, 1], [1, 0], [0, -1], [-1, 0] ]
    islands = []
    row_size.times do |row|
        col_size.times do |col|
            next if grid[row][col] == water || visited[row][col]

            islands << [row, col]
            while !islands.empty?
                current_row, current_col = islands.pop
                visited[current_row][current_col] = true
                offsets.each do |row_offset, col_offset|
                    next_row = current_row + row_offset
                    next_col = current_col + col_offset
                    is_in_grid = 0 <= next_row && next_row < row_size && 0 <= next_col && next_col < col_size
                    next unless is_in_grid
                    next if grid[next_row][next_col] == water || visited[next_row][next_col]

                    islands << [next_row, next_col]
                end
            end
            num_islands += 1
        end
    end
    num_islands
end
```
