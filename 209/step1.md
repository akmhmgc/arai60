# step1 何も見ずに解く

愚直に計算すると二重ループになる。numsのサイズは最大で10^5なので間に合わない。
subarrayの合計を考える時に同じ計算を何回もしたくないので累積和を使って、二分探索を使うと解けそう。
これだと時間計算量はO(NlogN)で1秒以内に間に合う。
空間計算量はO(N)

```ruby
# @param {Integer} target
# @param {Integer[]} nums
# @return {Integer}
def min_sub_array_len(target, nums)
    nums_size = nums.size
    prefix_size = nums_size + 1
    prefix_sums = Array.new(prefix_size, 0)
    nums.each_with_index { |num, i| prefix_sums[i + 1] = prefix_sums[i] + num }

    min_index_equal_or_greater = lambda do |left, min_val|
        right = prefix_size
        while left < right
            middle = (left + right) / 2
            if prefix_sums[middle] < min_val
                left = middle + 1
                next
            end
            right = middle
        end
        left == prefix_size ? Float::INFINITY : left
    end

    min_size = Float::INFINITY
    nums_size.times do |i|
        min_val = target + prefix_sums[i]
        min_index = min_index_equal_or_greater.call(i + 1, min_val)
        min_size = [min_size, min_index - i].min
    end
    min_size == Float::INFINITY ? 0 : min_size
end
```

具体的な例を複数考えると、先頭から値を合計していきtarget以上になった時の配列の長さを答えの候補とする。
そしてtargetより小さくなるまでsubarrayの開始インデックスを進めるという方法で解けることを思いつく。

```ruby
# @param {Integer} target
# @param {Integer[]} nums
# @return {Integer}
def min_sub_array_len(target, nums)
    min_size = Float::INFINITY
    subarray_sum = 0
    left = 0
    nums.each_with_index do |num, right|
        while subarray_sum + num >= target
            min_size = [min_size, right - left + 1].min
            subarray_sum -= nums[left]
            left += 1
        end
        subarray_sum += num
    end
    min_size == Float::INFINITY ? 0 : min_size
end
```
