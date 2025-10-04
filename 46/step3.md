# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {Integer[]} nums
# @return {Integer[][]}
def permute(nums)
    permutes = [[]]
    while permutes.first.size != nums.size
        permutes = permutes.each_with_object([]) do |permute, next_permutes|
            next_permutes.concat((nums - permute).map { |num| permute + [num] })
        end
    end
    permutes
end
```
