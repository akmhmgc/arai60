# step1 何も見ずに解く
[1,2,3]の場合、
[[]]
[[1], [2], [3]]
[[1, 2], [1, 3], [2, 3],[2, 1], [3, 1], [3, 2]]
といった形で増やしていけば良さそう。
つまり、配列の各permutationにまだ追加していない値があれば追加したものを加えるというループを繰り返してpermutationの長さがnumsのサイズになれば終了すれば良い。

```ruby
# @param {Integer[]} nums
# @return {Integer[][]}
def permute(nums)
    permutations = [[]]
    while permutations.first.size < nums.size
        next_permutations = []
        permutations.each do |permutation|
            next_permutations.concat((nums - permutation).map { |num| (permutation + [num]) })
        end
        permutations = next_permutations
    end
    permutations
end
```

ある時点でのpermutationの長さをkとすると、
```
(nums - permutation).map { |num| (permutation + [num]) }
```
の部分で(n - k) * kの計算量がかかる。
これを各階層のノードの数とかけて0 - nのkについて合計すると、計算量はO(n * n!)になる。
空間計算量は最終的に作られるpermutationの数 * 各permutationの長さなのでO(n * n!)
nの最大値が6なので1秒以内で間に合うが、少しでも大きくなったらどうしようもなさそう。
