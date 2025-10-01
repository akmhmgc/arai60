# step1 何も見ずに解く
問題の制約上binary searchを使う。（Rubyでも普通にループでやっても間に合いそうだが）

target以上となる最小のインデックスを返せば良い。
numsにそれを満たす値がなければ配列のサイズを返す。

インデックスleft以上、right未満の範囲を調査する。初期値はそれぞれ0, 配列のサイズとする。
(left + right) / 2をmiddleとして、nums[middle]の値が
target以上であればleft以上、middle未満のインデックスの範囲に答えがあるかもしれないのでright = middleとして探索を続ける
target未満であればmiddle + 1以上、right未満のインデックスの範囲に答えがあるかもしれないのでleft = middle + 1として探索を続ける

rightは常に答えの候補になり得えて、探索の度に答えに近づくので探索が打ち切られた時のright(left)が答えになるはず。

時間計算量はO(logN)
空間計算量はO(1)

```ruby
# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer}
def search_insert(nums, target)
    l = 0
    r = nums.size
    while l < r
        m = (r + l) / 2
        if nums[m] >= target
            r = m
        else
            l = m + 1
        end
    end
    r
end
```
