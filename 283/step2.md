# step2 他の方の解答を見る
https://github.com/fhiyo/leetcode/pull/54

https://github.com/fhiyo/leetcode/pull/54/files#diff-2f8b85074aa38861aa9dd6fbe0c5f1b540a06f8618d7552b4ffd05da21f795d3R40-R46

先頭にそれぞれleft,rightをおく
1. rightの位置に0がない時はleftとrightの値を交換してleftを進める
2. rightを進める

1,2を繰り返してrightが末尾までいったら終了
という考え方。
step1ではleftの位置に何があるかを含めていたが、要らなかった。

```ruby
# @param {Integer[]} nums
# @return {Void} Do not return anything, modify nums in-place instead.
def move_zeroes(nums)
    left = 0
    nums.size.times do |right|
        next if nums[right].zero?

        nums[left], nums[right] = nums[right], nums[left]
        left += 1
    end
end
```

https://github.com/fhiyo/leetcode/pull/54/files/40f6172e4c7a6b29303a6b66464dd512300ac477#diff-2f8b85074aa38861aa9dd6fbe0c5f1b540a06f8618d7552b4ffd05da21f795d3R87-R98


```ruby
# @param {Integer[]} nums
# @return {Void} Do not return anything, modify nums in-place instead.
def move_zeroes(nums)
    last_non_zero_index = 0
    nums.each do |num|
        next if num.zero?
        nums[last_non_zero_index] = num
        last_non_zero_index += 1
    end
    last_non_zero_index.upto(nums.size - 1).each { |i| nums[i] = 0 }
end
```

> まとめて 0 fill は、loop unrolling できたりするのでちょっと嬉しいこともあるでしょう。
https://github.com/fhiyo/leetcode/pull/54/files/40f6172e4c7a6b29303a6b66464dd512300ac477#r1729230640

loop unrollingという言葉を初めて知った。

RubyでもArray#fillだと処理を最適化しているようだった。

```ruby
require 'benchmark'

n = 10 ** 6
array1 = Array.new(n, 1)
array2 = Array.new(n, 1)
Benchmark.bm(7) do |x|
  x.report("loop")   { (0...n).each { |i| array1[i] = 0 } }
  x.report("fill") { array2.fill(0, 0...n) }
end
```

```
              user     system      total        real
loop      0.028068   0.000177   0.028245 (  0.028289)
fill      0.000235   0.000150   0.000385 (  0.000391)
```

なので以下のように書ける。

```ruby
# @param {Integer[]} nums
# @return {Void} Do not return anything, modify nums in-place instead.
def move_zeroes(nums)
    last_non_zero_index = 0
    nums.each do |num|
        next if num.zero?
        nums[last_non_zero_index] = num
        last_non_zero_index += 1
    end
    nums.fill(0, last_non_zero_index...(nums.size))
end
```
