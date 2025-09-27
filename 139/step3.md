# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {String} str
# @param {String[]} word_dict
# @return {Boolean}
def word_break(str, word_dict)
    unreachable_suffixes = Set.new
    is_reachable = ->(str){
        return true if str.empty?
        return false if unreachable_suffixes.include?(str)

        word_dict.each do |word|
            next unless str.start_with?(word)
            return true if is_reachable.call(str[word.size..-1])
        end
        unreachable_suffixes << str
        false
    }
    is_reachable.call(str)
end
```
