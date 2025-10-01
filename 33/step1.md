# step1 何も見ずに解く
- 求めたいもの
  - targetの候補になるものを求める。最後にtargetと一致するかどうかをチェックする。
- どうやって範囲を狭めていくか
  - leftより左はtargetではない
  - rightより右はtargetではない
- 終了条件
  - left == rightとなると、rightまたはleftが答えの候補になる
- 作業
  - 中央のインデックスはmiddle = (left + right) / 2とする（切り捨て）
    - 範囲の更新は以下でないと無限ループになる
      - left = middle + 1
      - right = middle
  - middleを含む右が昇順の時
    - targetが(middle + 1)の値以上rightの値以下の時
      - middleを含む左にtargetは存在しないのでleft = middle + 1に更新できる
    - targetが(middle + 1)の値より小さい or rightの値より大きい時
      - middleより右にtargetは存在しないのでright = middleに更新できる
    - ※ 「targetがmiddleの値以上rightの値以下の時」としていないのは、leftの更新によって範囲を1以上狭められないパターンが出るため
  - middleを含む左が昇順の時
    - targetがleftの値以上middleの値以下の時
      - middleより左にtargetが存在しないのでright = middleに更新できる
    - targetがleftより小さい or middleより大きい時
      - middleを含む左にはtargetは存在しないのでleft = middle + 1で更新できる

考え方的に間違ってない気がするが、考えるのに疲れる…

時間計算量はO(logN)で、空間計算量はO(1)
numsの最大サイズは10^4なので余裕で1秒以内に間に合う

```ruby
# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer}
def search(nums, target)
    left = 0
    right = nums.size - 1
    while left < right
        mid = (left + right) / 2
        if nums[mid] <= nums[right]
            if nums[mid + 1] <= target && target <= nums[right]
                left = mid + 1
            else
                right = mid
            end
        else
            if nums[left] <= target && target <= nums[mid]
                right = mid
            else
                left = mid + 1
            end
        end
    end
    not_existed = -1
    nums[left] == target ? left : not_existed
end
```

