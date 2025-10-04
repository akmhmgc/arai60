# step2 他の方の解答を見る

## 使用中のnumsをSetにいれるかどうか
https://github.com/Ryotaro25/leetcode_first60/pull/54#discussion_r1986035628

numsの中でpermutationで使われていないものを取り出す時に線形に検索するとnが乗ってしまう。
これは(Intersection of Two Arrays)[https://leetcode.com/problems/intersection-of-two-arrays/editorial/]と同じ話かと思った。

https://github.com/tokuhirat/LeetCode/pull/50/files#r2278840164
一方で、問題の制限はnが6以下であるし、オーバーヘッドを加味すると配列のまま計算する方が速いかもしれない。
ハッシュテーブルにした方が速くなるくらいのサイズだとそもそも現実的な計算時間で終わらなくなっている気もするな…

と思ってRubyのコードを読んだところ、特定の長さの配列まではハッシュテーブルを使わずに線形探索していた。
そういえば積集合をとる`&`も同じことをしていたんだった。
ref: https://github.com/ruby/ruby/blob/5257e1298c4dc4e854eaa0a9fe5e6dc5c1495c91/array.c#L5558-L5583

## 再帰で解く
https://github.com/ryosuketc/leetcode_arai60/pull/39

```ruby
# @param {Integer[]} nums
# @return {Integer[][]}
def permute(nums)
    permute_helper = lambda do |nums|
        permutes = []
        append_permutes = lambda do |permute, nums|
            if nums.empty?
                permutes << permute 
                return
            end
            nums.each_with_index do |num, i|
                new_permute = permute + [num]
                new_nums = nums[0...i] + nums[(i + 1)..-1]
                append_permutes.call(new_permute, new_nums)
            end
        end
        append_permutes.call([], nums)
        permutes
    end
    permute_helper.call(nums)
end
```

## step1の改善

```ruby
# @param {Integer[]} nums
# @return {Integer[][]}
def permute(nums)
    permutes = [[]]
    while permutes.first.size != nums.size
        permutes = permutes.each_with_object([]) do |permute, next_permutes|
            next_permutes.concat((nums - permute).map { |num| permute + [num] })
        end
    end
    permutes
end
```
