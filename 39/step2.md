# step2 他の方の解答を見る
## 計算量
https://github.com/Mike0121/LeetCode/pull/1#discussion_r1578212926

計算量は全くわからないので一旦考えないことにした。興味が出たら読む。

## step1の改善
https://github.com/fhiyo/leetcode/pull/52

step1ではtotalをいちいち計算していたが引数に渡すこともできる。
また、[a,b,c,d]と昇順にソートしておけば、bを追加した時に合計がtarget以上になった場合それ以降は探索する必要がなくなる。

```ruby
# @param {Integer[]} candidates
# @param {Integer} target
# @return {Integer[][]}
def combination_sum(candidates, target)
    sorted_candidates = candidates.sort
    combinations = []
    combination_sum_helper = lambda do |index, total, candidate|
        if total == target
            combinations << candidate.dup
            return
        end
        (index...(sorted_candidates.size)).each do |next_index|
            new_total = total + sorted_candidates[next_index]
            break if new_total > target

            candidate << sorted_candidates[next_index]
            combination_sum_helper.call(next_index, new_total, candidate)
            candidate.pop
        end
    end
    combination_sum_helper.call(0, 0, [])
    combinations
end
```
candidateを再帰関数のなかで持たない書き方もできる。
できるけど個人的にわざわざ`combination_sum_helper`の外に露出させるメリットを感じなかった。

```ruby
# @param {Integer[]} candidates
# @param {Integer} target
# @return {Integer[][]}
def combination_sum(candidates, target)
    sorted_candidates = candidates.sort
    combinations = []
    partial_combination = []
    combination_sum_helper = lambda do |index, total|
        if total == target
            combinations << partial_combination.dup
            return
        end
        (index...(sorted_candidates.size)).each do |next_index|
            new_total = total + sorted_candidates[next_index]
            break if new_total > target

            partial_combination << sorted_candidates[next_index]
            combination_sum_helper.call(next_index, new_total)
            partial_combination.pop
        end
    end
    combination_sum_helper.call(0, 0)
    combinations
end
```

## 他のバックトラックの思考法
https://github.com/fhiyo/leetcode/pull/52#discussion_r1690161771
step1を他のバックトラックの思考法で書いてみる。
(step1で合計値を毎回計算している部分は改善していない)

> B を一つ使うか、C 以降しか使ってはいけないか、に分岐する。

```ruby
# @param {Integer[]} candidates
# @param {Integer} target
# @return {Integer[][]}
def combination_sum(candidates, target)
    combinations = []
    combination_sum_helper = lambda do |index, candidate|
        return if candidate.sum > target
        if candidate.sum == target
            combinations << candidate.dup
            return
        end

        # 同じindexの値を使う
        candidate << candidates[index]
        combination_sum_helper.call(index, candidate)
        candidate.pop

        # 次のindexの値を使う
        return if index + 1 >= candidates.size
        combination_sum_helper.call(index + 1, candidate)
    end
    combination_sum_helper.call(0, [])
    combinations
end
```

> B の使う数を列挙して分岐し、C 以降しか使ってはいけないに遷移する。

```ruby
# @param {Integer[]} candidates
# @param {Integer} target
# @return {Integer[][]}
def combination_sum(candidates, target)
    combinations = []
    combination_sum_helper = lambda do |index, total, partial_combination|
        if total == target
            combinations << partial_combination.dup
            return
        end
        return unless index < candidates.size
        max_usage = (target - total) / candidates[index]
        (1..max_usage).each do |i|
            new_total = total + candidates[index] * i
            i.times { partial_combination << candidates[index] }
            combination_sum_helper.call(index + 1, new_total, partial_combination)
            i.times { partial_combination.pop }
        end
        combination_sum_helper.call(index + 1, total, partial_combination)
    end
    combination_sum_helper.call(0, 0, [])
    combinations
end
```

色々考え方があって面白い。
「要するに抜け漏れなく分類できていればよくて、パターンは複数考えられる」という抽象度の高い理解が出来ているといろんな人のコードが早く読めるようになるし、自分のコードも自由に書き換えられる。
