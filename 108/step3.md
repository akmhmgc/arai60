# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end
# @param {Integer[]} nums
# @return {TreeNode}
def sorted_array_to_bst(nums)
    sorted_array_to_bst_helper = ->(start_index, end_index) {
        return nil if start_index > end_index

        middle_index = (start_index + end_index) / 2
        root = TreeNode.new(nums[middle_index])
        root.left = sorted_array_to_bst_helper.call(start_index, middle_index - 1)
        root.right = sorted_array_to_bst_helper.call(middle_index + 1, end_index)
        root
    }
    sorted_array_to_bst_helper.call(0, nums.size - 1)
end
```
