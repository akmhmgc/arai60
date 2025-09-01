# step1 何も見ずに解く
何も考えずにやると、配列を先頭から見てその先にある値を合計していって、kに合致するやつをカウントする方法が考えられる。
これだとO(N^2)になる。Rubyだと間に合うか怪しい。毎回合計するのが無駄になるので合計を持ちながらループを回すことにする。

配列を先頭から見る。
1. 累積和を計算する
1. 累積和と出現頻度の組み合わせの表を見て、現在の累積和 - kのものがあればカウントに加える
1. 累積和と出現頻度に加える
1. 次のループに回す

という解き方ができそう。
ループ間で引き渡すのは累積和、累積和と出現頻度の組み合わせと、どこまで配列を見たかという情報があれば良い。
配列の長さをNとすると時間計算量はO(N)、空間計算量もO(N)
配列の長さは最大で2 * 10^4なので1秒以内に余裕で間に合う。

```ruby
# @param {Integer[]} nums
# @param {Integer} k
# @return {Integer}
def subarray_sum(nums, k)
    subarray_sum_count = 0
    prefix_sum = 0
    prefix_sum_to_count = Hash.new(0)
    prefix_sum_to_count[0] = 1
    nums.each do |num|
        prefix_sum += num
        subarray_sum_count += prefix_sum_to_count[prefix_sum - k]
        prefix_sum_to_count[prefix_sum] += 1
    end

    subarray_sum_count
end
```

例えばJavaだとLinkedHashMapを`accessOrder=true`で使えばprefix_sumという変数を用意しなくても最後に更新したものを取り出して計算することもできる
デフォルトの`accessOrder=false`だと更新するときはノードの位置は変わらないので最後に更新した値を取り出せない。

もし、配列の値が正の整数であるという条件であれば、累積和のリストを先頭から見ていき、今のポインターまでの累積和+kがあるかどうかを二分探索で探す方法がありそう。（Setでも良い）
また、0以上の整数であれば、累積和のリストを用意して、二つのポインターを用意して前後のポインタの値の差分を計算して、kより小さければ前のポインタを進めて、小さければ後ろのポインタを進める、という作業を繰り返してkに合致すればカウントするという方法がありそう。
