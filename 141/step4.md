# step4 レビューを受けて解答を修正

```ruby
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end

# @param {ListNode} head
# @return {Boolean}
def hasCycle(head)
    node = head
    visited_nodes = Set.new

    while node
        return true if visited_nodes.include?(node)

        visited_nodes.add(node)
        node = node.next
    end
    
    false
end
```

RubyのSetでは内部記憶としてHashを使っていて、ハッシュ衝突の対策としてprobing を使っているらしい。
ref: https://github.com/ruby/ruby/blob/11c8bad64b31c125b903547bb3eed0ede8f0f8e2/st.c#L7-L13
