# step1 何も見ずに解く
前から値を見ていって、その値あるいはそれより右にある値をcandidateに入れて次に渡す。
次の人は入れた値あるいはそれより右にある値からcandidateに入れる値を選択しなくてはならない。
という感じで行けそう。

targetをcandidatesの最も小さい値で割った分だけ探索の深さが増えるので
candidatesの要素数をN、candidatesの最小値をCmとするとN^(target / Cm)くらいまで計算量が膨らむのではないか？

こういう多項式時間ではない計算量の見積もりはした方が良いのか悩む。
現実だと、入力の上限が変わったら容易に現実的な時間で計算が終わりそうにないことと、そもそも要件を変えることができないかを考える気がする。
計算量の見積もりをオーダー記法で考えるより、入力サイズを変えてみて答えを返すまでの許容できる閾値を探るかもしれない。

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
        (index...(candidates.size)).each do |next_index|
            candidate << candidates[next_index]
            combination_sum_helper.call(next_index, candidate)
            candidate.pop
        end
    end
    combination_sum_helper.call(0, [])
    combinations
end
```
