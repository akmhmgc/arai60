# step3 3回続けて10分以内に書いてエラーを出さなければOKとする

```ruby
# @param {String} begin_word
# @param {String} end_word
# @param {String[]} word_list
# @return {Integer}
def ladder_length(begin_word, end_word, word_list)
    not_existed = 0
    return not_existed unless word_list.include?(end_word)
    
    patterns = ->(word) {
        result = []
        word.size.times do |i|
            result << [word[0...i], word[(i + 1)..-1]]
        end
        result
    }
    pattern_to_words = Hash.new { |hash, key| hash[key] = [] }
    word_list.each do |word|
        patterns.call(word).each do |pattern|
            pattern_to_words[pattern] << word
        end
    end

    visited = Set.new([begin_word])
    words = [begin_word]
    result = 1
    while !words.empty?
        next_words = []
        words.size.times do
            word = words.pop
            return result if word == end_word

            patterns.call(word).each do |pattern|
                pattern_to_words[pattern].each do |next_word|
                    next if visited.include?(next_word)

                    next_words << next_word
                    visited << next_word
                end
            end
        end
        words = next_words
        result += 1
    end
    not_existed
end
```
