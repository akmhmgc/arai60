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

## オプショナルな質問
https://github.com/Ryotaro25/leetcode_first60/pull/46#discussion_r1869993674


```ruby
# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer}
def search_insert(nums, target)
    left = 0
    right = nums.size
    while left < right
        middle = (right + left) / 2
        if nums[middle] >= target
            right = middle
        else
            left = middle + 1
        end
    end
    right
end
```

後続の問題を解いていて、理解してなかったことに気づいたので以下を考える。
`nums.back()`の話はRubyだとわからなかったので一旦飛ばす。
ref: https://github.com/Ryotaro25/leetcode_first60/pull/46#discussion_r1869993674

### 「2で割る処理がありますがこれは切り捨てでも切り上げでも構わないのでしょうか。」
たとえば、nums = [0, 1, 2], target = 3の時にleft,rightは0, 3なのでmiddleは2となる。
nums[middle]は2となり、nums[m] < targetなのでleft = middle + 1 = 2 + 1 = 3となり、leftが更新されずに無限ループになる。

### nums[middle] >= target とありますが、これは > でもいいですか。」
たとえば、nums = [0, 1, 2], target = 1の時、left,rightは0, 3なのでmiddleは1となる。
nums[middle]は1となり、nums[middle] > targetを満たさないので、left = 2となって、最終的に2を返す。
つまり、target以上ではなく、targetより大きくてインデックスが最も小さくなるインデックスを返すことになる。

### 「right の初期値は nums.size - 1 でもいいですか。」
right == leftが答えになるので、`nums.size`が答えになるパターンで間違った答えを返す。

## 思考の整理
上でもまだしっくり来なかったので、以下のように整理した。
### 求めたいもの
target以上となる最小のインデックス

### 範囲の絞り方
- left
	1. 自分より左側はtargetより小さい
	2. ~~自分より左側はtarget以下~~
		- これが言えても、targetより右がtarget以上とは言えない（以上かもしれないし、targetより大きいかもしれない）ので使えない
- right
	3. 自分を含む右側はtarget以上
	4. 自分より右側はtarget以上

1と3の組み合わせの場合、left == rightになるまで絞り込めば、leftより左はtargetより小さく、rightを含む右はtarget以上であると言えるのでleft = rightがtarget以上となる最小のインデックスと言える。

1と4の組み合わせの場合、left == right + 1になるまで絞り込めば、leftより左はtargetより小さく、rightより右側はtarget以上なのでleft == right + 1がtarget以上となる最小のインデックスと言える。

### middleの処理
- middle = (left + right) / 2 とする（切り捨て）
- middle = (left + right + 1) / 2 とする（切り上げ）

切り捨てではmiddleがleftと一致することがあるし、切り上げではmiddleがrightと一致することがある。

範囲の絞り方の1と3の組み合わせの場合は以下のように考える。
middleの値がtargetより小さいときは、leftをmiddle + 1に更新すれば、leftより左はtargetより小さいと言える。
middleの値がtarget以上であれば、rightをmiddleに更新すればrightを含む右はtarget以上だと言える。
rightをmiddleに更新するので、切り上げのパターンではright更新されないことがあり、無限ループになる。
なので切り上げの考えは使えない。

```ruby
def search_insert(nums, target)
    left = 0 # leftより左側はtargetより小さい
    right = nums.size # rightを含む右側はtarget以上
    while left < right # 停止条件はleft == right
        middle = (right + left) / 2 # 切り捨て
        if nums[middle] >= target
            right = middle # rightを含む右はtarget以上だと言える
        else
            left = middle + 1 # leftより左はtargetより小さいと言える
        end
    end
    left
end
```

これは動かない
```ruby
def search_insert(nums, target)
    left = 0 # leftより左側はtargetより小さい
    right = nums.size # rightを含む右側はtarget以上
    while left < right # 停止条件はleft == right
        middle = (right + left + 1) / 2 # 切り上げ
        if nums[middle] >= target
            # middle == rightになり、更新されなくて無限ループになり得る
            right = middle # rightを含む右はtarget以上だと言える
        else
            left = middle + 1 # leftより左はtargetより小さいと言える
        end
    end
    left
end
```

範囲の絞り方の1と4の組み合わせの場合は以下のように考える。
middleの値がtargetより小さいときは、leftをmiddle + 1に更新すれば、leftより左はtargetより小さいと言える。
middleの値がtarget以上であれば、rightをmiddle - 1に更新すればrightより右はtarget以上だと言える。
この場合は、切り上げでも切り捨てでもmiddleがleft,right両方ともに一致することがないので無限ループせずに動く。

```ruby
def search_insert(nums, target)
    left = 0 # leftより左側はtargetより小さい
    right = nums.size - 1 # rightより右側はtarget以上
    while left <= right # 停止条件はleft == right + 1
        middle = (right + left) / 2 # 切り捨て
        if nums[middle] >= target
            right = middle - 1 # rightより右はtarget以上だと言える
        else
            left = middle + 1 # leftより左はtargetより小さいと言える
        end
    end
    left
end
```

```ruby
def search_insert(nums, target)
    left = 0 # leftより左側はtargetより小さい
    right = nums.size - 1 # rightより右側はtarget以上
    while left <= right # 停止条件はleft == right + 1
        middle = (right + left + 1) / 2 # 切り上げ
        if nums[middle] >= target
            right = middle - 1 # rightより右はtarget以上だと言える
        else
            left = middle + 1 # leftより左はtargetより小さいと言える
        end
    end
    left
end
```
