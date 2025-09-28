# step2 他の方の解答を見る
## 両端を含める場合
https://discord.com/channels/1084280443945353267/1192736784354918470/1199018938005213234

target以上となる最小のインデックスを返せば良い。
numsにそれを満たす値がなければ配列のサイズを返す。

インデックスleft以上、right以下の範囲を調査する。初期値はそれぞれ0, 配列のサイズ - 1とする。
(left + right) / 2をmiddleとして、nums[middle]の値が
target以上であればleft以上、middle - 1以下のインデックスの範囲に答えがあるかもしれないのでright = middle - 1として探索を続ける
target未満であればmiddle + 1以上、right未満のインデックスの範囲に答えがあるかもしれないのでleft = middle + 1として探索を続ける

right + 1は常に答えの候補になり得えて、探索の度に答えに近づくので探索が打ち切られた時のright + 1が答えになるはず。

```ruby
# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer}
def search_insert(nums, target)
    l = 0
    r = nums.size - 1
    while l <= r
        m = (r + l) / 2
        if nums[m] >= target
            r = m - 1
        else
            l = m + 1
        end
    end
    r + 1
end
```

考え方を自然言語にしてからコードを書くのはそれほど難しくないけど、人のコードを読んだ時に
コードから考え方に戻す作業が難しい。

> というわけで、書き方を固定してもいいけれども、幅のある表現を読めるようにしてくださいね、ということです。
https://github.com/Fuminiton/LeetCode/pull/41#discussion_r2080995529
