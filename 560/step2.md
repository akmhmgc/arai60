# step2 他の方の解答を見る
- https://github.com/maeken4/Arai60/pull/15
- https://github.com/Hurukawa2121/leetcode/pull/16
- https://github.com/katataku/leetcode/pull/15

> https://github.com/katataku/leetcode/pull/15/files#r1898174496

resultという変数名は頑なに使っていなかったのだが、確かに中間の状態を読み手が想像できるのであれば問題ない。
その点でいうお、`subarray_sum`というメソッド名がもう少しマシなものであれば`result`であったとしても読みやすいと思う。
メソッド名が`subarray_sum_count`で変数名が`result`とかであれば良いかな。

```ruby
# @param {Integer[]} nums
# @param {Integer} k
# @return {Integer}
def subarray_sum(nums, k)
    result = 0
    prefix_sum = 0
    prefix_sum_to_count = Hash.new(0)
    prefix_sum_to_count[0] = 1
    nums.each do |num|
        prefix_sum += num
        result += prefix_sum_to_count[prefix_sum - k]
        prefix_sum_to_count[prefix_sum] += 1
    end

    result
end
```
