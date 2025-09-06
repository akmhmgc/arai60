# step1 何も見ずに解く
ある島から、行ける島を全て探索して訪れた島をカウントする。
全て探索し終わった時の合計値を更新していく。

深さ優先探索でも幅優先探索でもUnionFindでも解ける。

## 深さ優先探索
gridの行・列の長さをM,Nとすると時間計算量はO(MN)となる。
行も列もそれぞれ最大50なので1秒以内に余裕で間に合う。
空間計算量もO(MN)となる。gridに破壊的変更を加えても良いのであればO(1)で解けなくもないが、そうしていない。
再帰の深さは最大でM*Nになる。Rubyだとデフォルトのスタックサイズだと簡単なフィボナッチ数の計算が10^4程度実行できる。
今回の処理ではスタックフレームが10倍になるとしてもオーバーフローはしないだろう。

```ruby
# @param {Integer[][]} grid
# @return {Integer}
def max_area_of_island(grid)
    water = 0
    row_size = grid.size
    col_size = grid.first.size
    visited = Array.new(row_size) { |i| Array.new(col_size, false) }
    offsets = [ [1, 0], [-1, 0], [0, 1], [0, -1]]
    area = 0
    visit_island = -> (row, col) {
        visited[row][col] = true
        area += 1
        offsets.each do |row_offset, col_offset|
            new_row = row + row_offset
            new_col = col + col_offset
            is_in_grid = 0 <= new_row && new_row < row_size && 0 <= new_col && new_col < col_size
            next unless is_in_grid
            next if grid[new_row][new_col] == water || visited[new_row][new_col]

            visit_island.call(new_row, new_col)
        end
    }
    result = 0
    row_size.times do |row|
        col_size.times do |col|
            next if grid[row][col] == water || visited[row][col]

            area = 0
            visit_island.call(row, col)
            result = [result, area].max
        end
    end
    result
end
```

## UnionFind
UnionFindの場合、計算量を削減する工夫をしなければ時間計算量はO(MN^2)となる。
これでも1秒以内に間に合いそう。

(Time Limit Exceeded)
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

    def union(node_x, node_y)
        # 遅くなるように、必ずサイズの大きいrootの親をサイズの小さいにrootにしている
        root_many_size = root(node_y)
        root_few_size = root(node_x)
        return if root_many_size == root_few_size

        @child_to_parent[root_few_size] = root_many_size
        @root_to_size[root_many_size] += @root_to_size[root_few_size]
    end

    def size(root)
        @root_to_size[root]
    end
end

# @param {Integer[][]} grid
# @return {Integer}
def max_area_of_island(grid)
    water = 0
    row_size = grid.size
    col_size = grid.first.size
    islands = Set.new
    row_size.times do |row|
        col_size.times do |col|
            next if grid[row][col] == water

            islands << [row, col]
        end
    end

    union_find_island = UnionFind.new(islands)
    offsets = [ [1, 0], [-1, 0], [0, 1], [0, -1]]
    islands.each do |row, col|
        offsets.each do |row_offset, col_offset|
            new_row = row + row_offset
            new_col = col + col_offset
            next unless islands.include?([new_row, new_col])

            union_find_island.union([row, col], [new_row, new_col])
        end
    end

    result = 0
    islands.each do |island|
        next unless union_find_island.root(island) == island

        result = [result, union_find_island.size(island)].max
    end
    result
end
```

これだと間に合わなかったのでunion by sizeで計算量の削減を行なった。

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

    def union(node_x, node_y)
        root_many_size = root(node_x)
        root_few_size = root(node_y)
        return if root_many_size == root_few_size

        if size(root_many_size) < size(root_few_size)
            root_many_size, root_few_size = root_few_size, root_many_size
        end

        @child_to_parent[root_few_size] = root_many_size
        @root_to_size[root_many_size] += @root_to_size[root_few_size]
    end

    def size(root)
        @root_to_size[root]
    end
end

# @param {Integer[][]} grid
# @return {Integer}
def max_area_of_island(grid)
    water = 0
    row_size = grid.size
    col_size = grid.first.size
    islands = Set.new
    row_size.times do |row|
        col_size.times do |col|
            next if grid[row][col] == water

            islands << [row, col]
        end
    end

    union_find_island = UnionFind.new(islands)
    offsets = [ [1, 0], [-1, 0], [0, 1], [0, -1]]
    islands.each do |row, col|
        offsets.each do |row_offset, col_offset|
            new_row = row + row_offset
            new_col = col + col_offset
            next unless islands.include?([new_row, new_col])

            union_find_island.union([row, col], [new_row, new_col])
        end
    end

    result = 0
    islands.each do |island|
        next unless union_find_island.root(island) == island

        result = [result, union_find_island.size(island)].max
    end
    result
end
```
