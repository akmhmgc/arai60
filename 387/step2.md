# step2 他の方の解答を見る
https://github.com/shining-ai/leetcode/pull/15

LinkedHashMapをRubyで実装した。

```ruby
class ListNode
    attr_accessor :key, :next, :prev
    def initialize(key)
        @key = key
        @next = nil
        @prev = nil
    end
end

class LinkedHashMap
    def initialize
        @hash = {}
        @dummy_head = ListNode.new(nil)
        @dummy_tail = ListNode.new(nil)
        @dummy_head.next = @dummy_tail
        @dummy_tail.prev = @dummy_head
    end

    def []=(key, value)
        if @hash[key]
            @hash[key] = value
            return
        end

        @hash[key] = [value, add_node(key)]
        value
    end

    def delete(key)
        return unless @hash[key]
        value = @hash[key].first

        delete_node(key)
        @hash.delete(key)
        value
    end

    def peek_first
        return nil if @dummy_head.next == @dummy_tail

        @hash[@dummy_head.next.key].first
    end

    private

    def delete_node(key)
        current_node = @hash[key].last
        prev_node = current_node.prev
        next_node = current_node.next
        prev_node.next = next_node
        next_node.prev = prev_node
    end

    def add_node(key)
        new_node = ListNode.new(key)
        prev_tail = @dummy_tail.prev
        prev_tail.next = new_node
        new_node.prev = prev_tail
        @dummy_tail.prev = new_node
        new_node.next = @dummy_tail
        new_node
    end
end

# @param {String} string
# @return {Integer}
def first_uniq_char(string)
    unique_character_to_index = LinkedHashMap.new
    existing_characters = Set.new
    string.each_char.with_index do |character, index|
        if existing_characters.include?(character)
            unique_character_to_index.delete(character)
            next
        end
        unique_character_to_index[character] = index
        existing_characters.add(character)
    end

    unique_character_to_index.peek_first || -1
end
```
