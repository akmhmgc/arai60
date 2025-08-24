# step2 他の方の解答を見る
## https://github.com/takumihara/leetcode/pull/1
インデックスが見つからなかったときにどうするかを考慮していなかった。
each_with_indexはレシーバーとなる配列を返り値として返すので、今のコードだと、インデックスが見つからなかったときに元の配列を返してしまう。

```ruby
[1,2].each_with_index do end
=> [1,2]
```

間違った解を返すことになるので[nil, nil]を返すのが良いだろう。
例外処理も考えたが、実務だとtargetを満たすインデックスが存在しないことは一定以上起こると考えると、呼び出し側で例外をキャッチして処理を分岐させることは処理のオーバーヘッドが大きいと考えてやめた。

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

    [nil, nil]
end
```
