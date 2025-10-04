# step2 他の方の解答を見る
## rightを含まないようにする
https://github.com/SuperHotDogCat/coding-interview/pull/31#discussion_r1647128733

rightをsubarrayに含めない方法
rightがi + 1の時はsubarrayはiまで合計されているべき。そうなると前のループでnums[i]が長さに足されている

```ruby
# @param {Integer} target
# @param {Integer[]} nums
# @return {Integer}
def min_sub_array_len(target, nums)
    min_size = Float::INFINITY
    prefix_sum = 0
    left = 0
    right = 0
    while right <= nums.size
        while prefix_sum >= target
            min_size = [min_size, right - left].min
            prefix_sum -= nums[left]
            left += 1
        end
        prefix_sum += nums[right] if right < nums.size
        right += 1
    end
    min_size == Float::INFINITY ? 0 : min_size
end
```

## 同じ値が入っている時
https://github.com/olsen-blue/Arai60/pull/50#discussion_r2005919622

> [0, 0, 1, 1, 2, 2] で 1 を探すのだったら何が欲しいのか。
2が欲しい場合、3が欲しい場合、4が欲しい場合、2-3どれかが欲しい場合。

同じ値がある時一番右の値が欲しいときはどうすれば良いか？欲しい値以下の最も右にあるインデックスを返せばよいと考えてみる。
これは欲しい値より大きい値で、最も左にあるインデックスのすぐ左を考えると良さそう。

なのでtargetより大きい最小のインデックスを求めることを考える。
leftより左はtarget以下の値しかないとする
rightあるいはrightより右はtargetより大きい値しかないとする

targetの位置の分類は以下
- middleより左
  - middleを含む右はtargetより大きいと言えるので、right = middleで更新できる
- middleまたはmiddleより右
  - middleより左はtargetより小さいと言えるので、left = middle + 1で更新できる

区間を一ずつ狭くするにはmiddleは切り捨て

```ruby
def at_most(nums, target)
    left = 0
    right = nums.size
    while left < right
        middle = (left + right) / 2
        if nums[middle] <= target
            left = middle + 1
        else
            right = middle
        end
    end
    left - 1
end

at_most([0, 0, 1, 1, 2, 2], 1) #=> 3
at_most([0, 0], -1) #=> -1
at_most([0, 1, 2], 3) #=> 2
```

