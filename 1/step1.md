# step1 何も見ずに解く
二重ループで合計がtargetと一致していればインデックスを返せば良い。答えが一つに決まっているのでこの方法で良い。
入力のサイズは最大で10^4なので時間計算量はO(N^2)でRubyだと一般的なCPUだと1秒以内に間に合いそうなので問題ないだろう。
空間計算量はO(1)

```ruby
# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def two_sum(nums, target)
    nums_size = nums.size
    (0..nums_size).each do |i|
        (i...nums_size).each do |j|
            return [i, j] if nums[i] + nums[j] == target && i != j
        end
    end
end
```

以下のような方針を考えた。
先頭から配列を見る。
今まで見た値とそのインデックスの組(nums_to_index)を前のループから引き継ぐ。
targetから現在の値を引いた値がnums_to_indexにあればそれぞれのインデックスを出力する。nums_to_indexに今の値とインデックスを追加する。
nums_to_indexを次のループに渡す。
nums_to_indexをHashSetにすれば計算量は以下になる。
時間計算量はO(N)
空間計算量はO(N)

```ruby
# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def two_sum(nums, target)
    nums_to_index = {}
    nums.each_with_index do |num, num_index|
        remain_index = nums_to_index[target - num]
        return [remain_index, num_index] if remain_index

        nums_to_index[num] = num_index
    end
end
```
