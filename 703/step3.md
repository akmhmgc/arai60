# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
class MinHeap
    def initialize
        @heap = []
    end

    def size
        @heap.size
    end
    
    def push(val)
        @heap << val
        sift_up(@heap.size - 1)
    end

    def pop
        swap(0, @heap.size - 1)
        min_val = @heap.pop
        sift_down(0)
        min_val
    end
    
    def peek
        @heap.first
    end

    private

    def parent_index(index)
        (index - 1) / 2
    end

    def left_child_index(index)
        index * 2 + 1
    end

    def right_child_index(index)
        index * 2 + 2
    end

    def swap(index1, index2)
        @heap[index1], @heap[index2] = @heap[index2], @heap[index1]
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
        smallest = left if left < @heap.size && @heap[left] < @heap[smallest]
        smallest = right if right < @heap.size && @heap[right] < @heap[smallest]
        return if smallest == parent

        swap(parent, smallest)
        sift_down(smallest)
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
        if  @top_k.size < @k
            @top_k.push(val)
        elsif @top_k.peek < val
            @top_k.pop
            @top_k.push(val)
        end
        @top_k.peek
    end
end
```
