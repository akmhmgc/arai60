# step1 何も見ずに解く

1. 数字と頻度のハッシュテーブルを作る
2. ハッシュテーブルを[数字, 頻度]の二次元配列に変換して頻度でソートする
3. top kをとる

という方法が浮かんだ。問題の意図とは違いそうだが…
時間計算量はO(N*logN)
空間計算量はO(N)
Nは10^5が最大なので間に合う。

```ruby
# @param {Integer[]} nums
# @param {Integer} k
# @return {Integer[]}
def top_k_frequent(nums, k)
    nums.each_with_object(Hash.new(0)) { |num, num_to_count | num_to_count[num] += 1 }
        .to_a.sort_by { |num, count| [(-1) * count, num ] }.map(&:first)[0...k]
end
```
kがnumsのサイズより大きい場合は、numsのサイズ分の上位を返すようにしている。同率でkに収まらないものは小さい数字から出すようにしている。

次に、Heapを使って解くこともできる。
けど計算量はほぼ変わらない割に、Rubyだと標準ライブラリでHeapがなくてコードが多くなるので選択はしないだろう。
計算量はO(N*logk)

```ruby
NumFreq = Struct.new(:num, :freq) do
    def more_frequent_than(num_freq)
        return true if freq > num_freq.freq
        return true if freq == num_freq.freq && num < num_freq.num
        false
    end
end

class MinHeap
    def initialize
        @heap = []
    end

    def empty?
        @heap.empty?
    end
    
    def push(num_freq)
        @heap << num_freq
        sift_up(@heap.size - 1)
    end

    def pop
        return nil if @heap.empty?
        swap(0, @heap.size - 1)
        min = @heap.pop
        sift_down(0)
        min
    end
    
    def peek
        @heap.first
    end

    def size
        @heap.size
    end
    
    private

    def parent_index(index)
        (index - 1) / 2
    end

    def has_parent?(index)
        parent_index(index) >= 0
    end
    
    def left_child_index(index)
        2 * index + 1
    end

    def has_left_child?(index)
        left_child_index(index) < @heap.size
    end

    def has_right_child?(index)
        right_child_index(index) < @heap.size
    end

    def right_child_index(index)
        2 * index + 2
    end

    def swap(index1, index2)
        @heap[index1], @heap[index2] = @heap[index2], @heap[index1]
    end

    def sift_up(child)
        return unless has_parent?(child)

        parent = parent_index(child)
        return unless @heap[parent].more_frequent_than(@heap[child])

        swap(child, parent)
        sift_up(parent)
    end

    def sift_down(parent)
        smallest = parent
        if has_left_child?(parent)
            left = left_child_index(parent)
            smallest = left if @heap[smallest].more_frequent_than(@heap[left])
        end
        if has_right_child?(parent)
            right = right_child_index(parent)
            smallest = right if @heap[smallest].more_frequent_than(@heap[right])
        end
        return if smallest == parent

        swap(parent, smallest)
        sift_down(smallest)
    end
end


# @param {Integer[]} nums
# @param {Integer} k
# @return {Integer[]}
def top_k_frequent(nums, k)
    num_to_freq = nums.each_with_object(Hash.new(0)) { |num, num_to_count | num_to_count[num] += 1 }.to_a
    top_k_heap = MinHeap.new
    num_to_freq.each do |num, freq|
        num_freq = NumFreq.new(num, freq)
        if top_k_heap.size < k
            top_k_heap.push(num_freq)
        elsif num_freq.more_frequent_than(top_k_heap.peek)
            top_k_heap.pop
            top_k_heap.push(num_freq)
        end
    end
    result = []
    while !top_k_heap.empty?
        result << top_k_heap.pop.num
    end
    result.reverse
end
```

同率の順番を気にしないのであればバケットソートが使える
これだと時間計算量はO(N)になる。

```ruby
def top_k_frequent(nums, k)
  num_to_freq = nums.each_with_object(Hash.new(0)) { |num, num_to_freq| num_to_freq[num] += 1 }

  nums_by_freq = Array.new(nums.size + 1) { [] }
  num_to_freq.each do |num, freq|
    nums_by_freq[freq] << num
  end

  result = []
  (nums_by_freq.size - 1).downto(1) do |freq|
    next if nums_by_freq[freq].empty?

    nums_by_freq[freq].each do |num|
      result << num
      return result if result.size == k
    end
  end
  result
end
```
