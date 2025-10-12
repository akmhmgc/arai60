# step2 他の方の解答を見る

- https://github.com/Ryotaro25/leetcode_first60/pull/9

MinHeapで実装する。
小さい順に上位k個数の値を保持しておけば良い。
Heapに値を追加する時の時間計算量はO(logN)
一番上の値を取り出した後にHeapの順を直す時の時間計算量もO(logN)
なのでnumsの長さをN, addが呼ばれる回数をMとすると、
最初にnumを入れるのにO(N*logN)でaddのクエリは合計で(M * log(k))になる。
なのでO(NlogN)
空間計算量はO(M + N)

```ruby
class MinHeap
    def initialize
        @heap = []
    end

    def peek
        @heap.first
    end

    def push(val)
        @heap << val
        sift_up(@heap.size - 1)
    end

    def pop
        return nil if @heap.empty?

        swap(0, @heap.size - 1)
        min = @heap.pop
        sift_down(0)
        min
    end

    def size
        @heap.size
    end

    private

    def parent_index(index)
        (index - 1) / 2
    end

    def left_child_index(index)
        2 * index + 1
    end

    def right_child_index(index)
        2 * index + 2
    end

    def sift_up(child)
        parent = parent_index(child)
        return if parent < 0 || @heap[parent] <= @heap[child]

        swap(child, parent)
        sift_up(parent)
    end

    def sift_down(parent)
        left = left_child_index(parent)
        right = right_child_index(parent)
        smallest = parent
        smallest = left if left < @heap.size && @heap[smallest] > @heap[left]
        smallest = right if right < @heap.size && @heap[smallest] > @heap[right]
        return if smallest == parent

        swap(parent, smallest)
        sift_down(smallest)
    end

    def swap(index1, index2)
        @heap[index1], @heap[index2] = @heap[index2], @heap[index1]
    end
end



class KthLargest

=begin
    :type k: Integer
    :type nums: Integer[]
=end
    def initialize(k, nums)
        raise ArgumentError, "k must be positive integer" if k <= 0
        raise ArgumentError, "Initial array size is too small to determine the top #{k}" if k > nums.size + 1
        @k = k
        @top_k = MinHeap.new
        nums.each { |num| add(num) }
    end


=begin
    :type val: Integer
    :rtype: Integer
=end
    def add(val)
        if @top_k.size < @k
            @top_k.push(val)
        elsif @top_k.peek < val
            @top_k.pop
            @top_k.push(val)
        end
        @top_k.peek
    end
end
```

https://github.com/shintaroyoshida20/leetcode/pull/13/files/db18f87a811ced86f26a72e4ee842f1b99d71b15#r2052161956

LeetCode環境でRubyは`Module: Algorithms`が使えるらしい。初めて知った。
https://www.rubydoc.info/github/kanwei/algorithms/Algorithms


https://github.com/fhiyo/leetcode/pull/10/files/0ee4b594d9657627d07ef9810b8f695611e366ac#r1605950261

メソッド単位でmutexを取る前提だと、topで値を返さないと
- スレッドA
  - 1. top
  - 3. pop
スレッドB
  - 2. pop

上の順番で処理が走ると不整合が起きる。

