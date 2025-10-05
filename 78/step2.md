# step2 他の方の解答を見る

## 再帰で解く
https://github.com/tokuhirat/LeetCode/pull/51/

pop()するところが難しいと感じたが、
subsetにnums[i]を追加して、子に参照を渡して答えを出した後にpopする、と考えれば自然か。
subsetsに追加するときに参照ではなく新しい配列を作らないとpopされて空のsubsetしか入っていないものが出力される。

```ruby
# @param {Integer[]} nums
# @return {Integer[][]}
def subsets(nums)
    subsets_helper = lambda do
        subsets = []
        count_subsets = lambda do |i, subset|
            if i == nums.size
                subsets << subset[0..-1]
                return
            end

            count_subsets.call(i + 1, subset)
            subset << nums[i]
            count_subsets.call(i + 1, subset)
            subset.pop
        end
        count_subsets.call(0, [])
        subsets
    end
    subsets_helper.call
end
```
