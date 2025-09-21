# step1 何も見ずに解く
i番目で終わるsubarrayの最大値がわかっていれば、i + 1番目で終わるsubarrayの最大値は、
- i番目で終わるsubarrayの最大値 + (i + 1)番目の値
- (i + 1)番目の値

のどちらからである。
時間計算量はO(N)でNの最大値は10^5なので1秒以内には間に合いそう。
空間計算量もO(N)

DPの項目にあるのを見てしまったのでDPで考えたが、その情報がなかったら上の解法を思いつきそうにない気がする。
まずは愚直に足してみて、無駄に計算しているところを見つけるはずなのでメモ化する方法を検討するかな。

```ruby
# @param {Integer[]} nums
# @return {Integer}
def max_sub_array(nums)
    return 0 if nums.empty?

    max_sub_array_end_at_index = Array.new(nums.size, 0)
    max_sub_array_end_at_index[0] = nums.first
    1.upto(nums.size - 1).each do |i|
        max_sub_array_end_at_index[i] = [max_sub_array_end_at_index[i - 1] + nums[i], nums[i]].max
    end
    max_sub_array_end_at_index.max
end
```

配列を用意する必要がないことに気づいたので以下のように修正した。
空間計算量はO(1)になる。

```ruby
# @param {Integer[]} nums
# @return {Integer}
def max_sub_array(nums)
    return 0 if nums.empty?

    max_sub_array_end_at_index = nums.first
    max_sub_array = nums.first
    1.upto(nums.size - 1).each do |i|
        max_sub_array_end_at_index = [max_sub_array_end_at_index + nums[i], nums[i]].max
        max_sub_array = [max_sub_array, max_sub_array_end_at_index].max
    end
    max_sub_array
end
```

番兵を使うともう少しシンプルにかける

```ruby
# @param {Integer[]} nums
# @return {Integer}
def max_sub_array(nums)
    return 0 if nums.empty?

    max_sub_array_end_at_index = -Float::INFINITY
    max_sub_array = -Float::INFINITY
    nums.each do |num|
        max_sub_array_end_at_index = [max_sub_array_end_at_index + num, num].max
        max_sub_array = [max_sub_array, max_sub_array_end_at_index].max
    end
    max_sub_array
end
```
