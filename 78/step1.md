# step1 何も見ずに解く
[1,2,3] の例を考える。
i番目までのsubsetsが決まっているとすると、i + 1番目までのsubsetsは
i番目のsubsetsに、それぞれのsubsetにi + 1番目を加えたものになる。

2までのsubsetsは
[[],[1],[2],[1,2]]であり、3までのsubsetsを考えると
[[],[1],[2],[1,2]]に3を加えた[[3],[1,3],[2,3],[1,2,3]]を合わせたものになる。
要するに、i + 1番目の時点でi番目までのsubsetsはi + 1番目までのsubsetsの中でi + 1番目を入れていないsubsetsなので、入れたsubsetsを追加すれば良い。

計算量を考える。
k + 1番目の数字を入れる時は以下の処理を行う。
i番目までのsubsetsは2^k個あり、それぞれのsubsetsにk + 1番目の数字を加えた新しいsubsetをつくって元のsubsetsに追加す
subsetsの長さの平均をk / 2とすると、新しいsubsetsを追加するコストは(2^k) * (k / 2)となる。
これを1からnのkまで考えるとO(n * 2^n)になりそう。
空間計算量もsubsetの平均サイズを n / 2と考えて個数が2^nなのでO(n * 2^n)


injectを使うとサクッと書けるので以下のようになった。

```ruby
# @param {Integer[]} nums
# @return {Integer[][]}
def subsets(nums)
  nums.inject([[]]) { |subsets, num| subsets.concat(subsets.map { |subset| subset + [num] }) }
end
```
