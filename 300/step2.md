# step2 他の方の解答を見る

## 処理を分ける
https://github.com/hayashi-ay/leetcode/pull/27/files#diff-b7fbb0dce1473afc0264185268f1a1ef6d682a3a8c997d43bc8bdd636a66ce4aR57-R61

step1で変数の命名だけで処理をわかりやすくしようとしていたが、処理を切り出すのも良い。

```ruby
# @param {Integer[]} nums
# @return {Integer}
def length_of_lis(nums)
    return 0 if nums.empty?

    lis_sizes = Array.new(nums.size, 1)
    get_max_lis_size_before_idx = -> (right_index) {
        max_size = 0
        right_index.times do |i|
            next unless nums[i] < nums[right_index]

            max_size = [max_size, lis_sizes[i]].max
        end
        max_size
    }
    nums.size.times do |i|
        lis_sizes[i] = get_max_lis_size_before_idx.call(i) + 1
    end
    lis_sizes.max
end
```


## NlogNの解法
`min_value_indexed_by_lis`はmin_value_indexed_by_lis[i]がlis size iを満たす最小の値を指す。
numsが`[1, 2, 7, 8, 3, 4, 7]`である時、
1
1, 2
1, 2, 7
1, 2, 7, 8
1, 2, 3, 8
1, 2, 3, 4
1, 2, 3, 4, 7
という風に更新していく。
更新する時に二分探索を使うとO(NlogN)で計算できる。


```ruby
# @param {Integer[]} nums
# @return {Integer}
def length_of_lis(nums)
    return 0 if nums.empty?

    min_value_indexed_by_lis = []
    nums.each do |num|
        index = min_index_greater_than_target(min_value_indexed_by_lis, num)
        if index == min_value_indexed_by_lis.size
            min_value_indexed_by_lis << num
        else
            min_value_indexed_by_lis[index] = num
        end
    end
    min_value_indexed_by_lis.size
end

def min_index_greater_than_target(list, val)
    left = 0
    right = list.size
    while left < right
        middle = (right + left) / 2
        if list[middle] < val
            left = middle + 1
        else
            right = middle
        end
    end
    left
end
```

## SegmentTree
初めて知った。SegmentTreeの実装自体はあまり難しくなかったが、使い所がまだあんまりしっくりきていない。

```ruby
class SegmentTree
  def initialize(n, init_val = 0)
    @n = n
    @items = Array.new(2 * n, init_val)
  end

  def query_max(left, right)
    res = 0
    left += @n
    right += @n
    while left <= right
      if left.odd?
        res = [res, @items[left]].max
        left += 1
      end
      if right.even?
        res = [res, @items[right]].max
        right -= 1
      end
      left /= 2
      right /= 2
    end
    res
  end

  def update(pos, val)
    pos += @n
    while pos > 0
      return if @items[pos] >= val
      @items[pos] = val
      pos /= 2
    end
  end
end

# @param {Integer[]} nums
# @return {Integer}
def length_of_lis(nums)
    return 0 if nums.empty?

    compress = -> (nums) {
        sorted_num_to_index = {}
        nums.sort.uniq.each_with_index do |num, index|
            sorted_num_to_index[num] = index
        end
        compressed_nums = Array.new(nums.size, 0)
        nums.each_with_index do |num, index|
            compressed_nums[index] = sorted_num_to_index[num]
        end
        compressed_nums
    }
    compressed_nums = compress.call(nums)
    segtree = SegmentTree.new(compressed_nums.size, 0)
    compressed_nums.each do |num|
        max_lis_lower_than_num = segtree.query_max(0, num - 1)
        segtree.update(num, max_lis_lower_than_num + 1)
    end
    segtree.query_max(0, nums.size - 1)
end
```
