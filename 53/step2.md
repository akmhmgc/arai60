# step2 他の方の解答を見る

https://discord.com/channels/1084280443945353267/1206101582861697046/1207749510797992026
DPで解くという前提を忘れて考えてみる。

累積和を計算した後に、累積和の差を計算して、最大値が答えになる。
この時点でループは二重なので間に合わない。

あるインデックスiを含む累積和の最大を考えると、iより左側にある最小の値とiまでの累積和の差が答えになるはず。
累積和を先頭から舐めて、最小の累積和を更新していく。そうすると現在の累積和と最小の累積和の差が最大値になる。

```ruby
# @param {Integer[]} nums
# @return {Integer}
def max_sub_array(nums)
    return 0 if nums.empty?

    max_sub_array = -Float::INFINITY
    min_prefix_sum = 0
    calculate_prefix_sums(nums).each do |prefix_sum|
        max_sub_array = [max_sub_array, prefix_sum - min_prefix_sum].max
        min_prefix_sum = [min_prefix_sum, prefix_sum].min
    end
    max_sub_array
end

def calculate_prefix_sums(nums)
    prefix_sums = Array.new(nums.size, 0)
    prefix_sums[0] = nums.first
    (1...(nums.size)).each do |i|
        prefix_sums[i] = nums[i] + prefix_sums[i - 1]
    end
    prefix_sums
end
```

累積和を先に計算せずに都度計算すると以下のようになる。

```ruby
# @param {Integer[]} nums
# @return {Integer}
def max_sub_array(nums)
    return 0 if nums.empty?
    
    max_sub_array = -Float::INFINITY
    min_prefix_sum = 0
    prefix_sum = 0
    nums.each do |num|
        prefix_sum += num
        max_sub_array = [max_sub_array, prefix_sum - min_prefix_sum].max
        min_prefix_sum = [min_prefix_sum, prefix_sum].min
    end
    max_sub_array
end
```

prefix_sum - min_prefix_sumをまとめると、以下のようになる。

```ruby
# @param {Integer[]} nums
# @return {Integer}
def max_sub_array(nums)
    return 0 if nums.empty?

    max_subarray_sum = -Float::INFINITY
    current_max_subarray_sum = 0
    nums.each do |num|
        current_max_subarray_sum = [current_max_subarray_sum + num, num].max
        max_subarray_sum = [max_subarray_sum, current_max_subarray_sum].max
    end
    max_subarray_sum
end
```

## 疑問
https://github.com/sakupan102/arai60-practice/pull/33/files/e00ec2d4d1d7dba2aeaa752a74d5737d49fce08b#r1609283493

>O(n **2) でよければ、ただの全探索でよいと思います。

```ruby
max_sum_values = 0
for i in range(len(nums)):
    sum_values = 0
    for j in range(i, len(nums)):
        sum_values += nums[j]
        max_sum_values = max(max_sum_values, sum_values)
return max_sum_values
```

累積和を作らない方法の方がむしろ自然かもしれない。
手計算でやると累積和より上のコードっぽいことをするかも。
この発想をすると、どのように発展させてO(N)の解法に至ればよいかわからなかった。
