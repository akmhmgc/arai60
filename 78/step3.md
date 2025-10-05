# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {Integer[]} nums
# @return {Integer[][]}
def subsets(nums)
    subsets = []
    subsets_helper = lambda do |index, subset|
        if index == nums.size
            subsets << subset.dup
            return
        end
        subsets_helper.call(index + 1, subset)
        subset << nums[index]
        subsets_helper.call(index + 1, subset)
        subset.pop
    end
    subsets_helper.call(0, [])
    subsets
end
```
