# step1 何も見ずに解く
幅優先探索か深さ優先探索が使えそう。

1. スタックから次に訪れる地点を取り出し、地点を訪れたことをチェックする。
2. その地点から進むことができる地点を探し、見つかった地点をスタックに入れる。

という操作を続けると一つの島の地点を全てチェックすることができる。

一番最初にスタックに訪れる地点を入れるのと、一つの島に所属する地点を全てチェックし終わってスタックが空になった後にどうするかで少し悩んだ。
gridの全ての点をループで回して、水がある or 既に行ったことがあればスキップして、そうでなければスタックに入れれば良いと考えた。

二次元配列の行、列のサイズをM,Nとすると時間計算量はO(MN)で空間計算量もO(MN)
それぞれ最大は300なので1秒以内であれば余裕で間に合う。

元のgridに破壊的変更を加えて良いのであればvisitedを使わなくて良いのだが、基本的に変更しない方が嬉しいことが多いので新しい配列を用意している。


## stackを利用した深さ優先探索

```ruby
# @param {Character[][]} grid
# @return {Integer}
def num_islands(grid)
    water = "0".freeze

    island_count = 0
    row_size = grid.length
    column_size = grid.first.size
    visited = Array.new(row_size) { |index| Array.new(column_size, false) }
    directions = [ [0, 1], [1, 0], [0, -1], [-1, 0] ]
    row_size.times do |row|
        column_size.times do |column|
            if grid[row][column] == water || visited[row][column] == true
                visited[row][column] = true
                next
            end

            island_count += 1
            points_to_visit = [[row, column]]
            while !points_to_visit.empty?
                current_row, current_column = points_to_visit.pop
                visited[current_row][current_column] = true
                directions.each do |row_offset, column_offset|
                    next_row = current_row + row_offset
                    next_column = current_column + column_offset
                    if next_row >= row_size || next_row < 0 || next_column >= column_size || next_column < 0 || grid[next_row][next_column] == water || visited[next_row][next_column] == true
                        next
                    end
                    points_to_visit << [next_row, next_column]
                end
            end
        end
    end
    island_count
end
```

与えられたgridの周りを全てwaterで囲うと`next_row >= row_size || next_row < 0 || next_column >= column_size || next_column < 0`の部分が不要になるが、個人的には認知負荷があがる気がするのでやっていない。

```ruby
# @param {Character[][]} grid
# @return {Integer}
def num_islands(grid)
    water = "0".freeze

    island_count = 0
    row_size = grid.length
    column_size = grid.first.size
    visited = Array.new(row_size) { |index| Array.new(column_size, false) }
    directions = [ [0, 1], [1, 0], [0, -1], [-1, 0] ]
    row_size.times do |row|
        column_size.times do |column|
            next if grid[row][column] == water || visited[row][column] == true

            visited[row][column] = true
            visited_points = [[row, column]]
            while !visited_points.empty?
                current_row, current_column = visited_points.pop
                directions.each do |row_offset, column_offset|
                    next_row = current_row + row_offset
                    next_column = current_column + column_offset
                    next if next_row >= row_size || next_row < 0 || next_column >= column_size || next_column < 0
                    next if grid[next_row][next_column] == water
                    next if visited[next_row][next_column] == true

                    visited[next_row][next_column] = true
                    visited_points << [next_row, next_column]
                end
            end
            island_count += 1
        end
    end
    island_count
end
```

- 訪れる前にstackに入れていたのを訪れた後に入れるように修正
  - それにあわせて`points_to_visit`を`visited_points`に変更したが、`visited`という変数もあるので少しわかりにくいかも…
- `island_count += 1`するタイミングを、島を全て訪れた後にした
- ループをスキップする条件を複数に分けた


## 再帰を利用した深さ優先探索
次に、深さ優先探索を再帰で解く

```ruby
# @param {Character[][]} grid
# @return {Integer}
def num_islands(grid)
    water = "0".freeze

    island_count = 0
    row_size = grid.length
    column_size = grid.first.size
    visited = Array.new(row_size) { |index| Array.new(column_size, false) }
    directions = [ [0, 1], [1, 0], [0, -1], [-1, 0] ]
    visit_next_point = ->(row, column) {
        directions.each do |row_offset, column_offset|
            next_row = row + row_offset
            next_column = column + column_offset
            is_in_grid = 0 <= next_row && next_row < row_size && 0 <= next_column && next_column < column_size
            next unless is_in_grid
            next if grid[next_row][next_column] == water
            next if visited[next_row][next_column] == true

            visited[next_row][next_column] = true
            visit_next_point.call(next_row, next_column)
        end
    }

    row_size.times do |row|
        column_size.times do |column|
            next if grid[row][column] == water || visited[row][column] == true

            visited[row][column] = true
            visit_next_point.call(row, column)
            island_count += 1
        end
    end
    island_count
end
```

Rubyだとメソッドの中にメソッドが定義できないので、インスタンス変数か無名関数等を使う必要があるので慣れない。

## 幅優先探索
次に、幅優先探索で実装してみる。
RubyにもQueueがあるっぽいが、今回は実装してみる。

Queueの実装は以下
```ruby
class MyQueue
  def initialize
    @size = 2
    @count = 0
    @ring_buffer = Array.new(@size, nil)
    @head = @tail = 0
  end

  def empty?
    @count == 0
  end

  def enque(item)
    extend_ring_buffer if @count == @size

    @ring_buffer[@tail] = item
    @count += 1
    @tail = (@tail + 1) % @size
  end

  def deque
    return nil if @count == 0

    item = @ring_buffer[@head]
    @count -= 1
    @head = (@head + 1) % @size
    item
  end

  private

  def extend_ring_buffer
    new_size = @size * 2
    new_ring_buffer  = Array.new(new_size, nil)
    @count.times do |i|
      new_ring_buffer[i] = @ring_buffer[(@head + i) % @size]
    end
    @ring_buffer = new_ring_buffer
    @size  = new_size
    @head  = 0
    @tail  = @count
  end
end
```

実装部分は以下

```ruby
# @param {Character[][]} grid
# @return {Integer}
def num_islands(grid)
    water = "0".freeze

    island_count = 0
    row_size = grid.length
    column_size = grid.first.size
    visited = Array.new(row_size) { |index| Array.new(column_size, false) }
    directions = [ [0, 1], [1, 0], [0, -1], [-1, 0] ]
    row_size.times do |row|
        column_size.times do |column|
            next if grid[row][column] == water || visited[row][column] == true

            visited[row][column] = true
            visited_points = MyQueue.new
            visited_points.enque([row, column])
            while !visited_points.empty?
                current_row, current_column = visited_points.deque
                directions.each do |row_offset, column_offset|
                    next_row = current_row + row_offset
                    next_column = current_column + column_offset
                    next if next_row >= row_size || next_row < 0 || next_column >= column_size || next_column < 0
                    next if grid[next_row][next_column] == water
                    next if visited[next_row][next_column] == true

                    visited[next_row][next_column] = true
                    visited_points.enque([next_row, next_column])
                end
            end
            island_count += 1
        end
    end
    island_count
end
```

