# step2 他の方の解答を見る
- https://discord.com/channels/1084280443945353267/1200089668901937312/1216123084889788486

step1でTime Limit Exceededだったコードの改善を考えた。

(Time Limit Exceeded)
```ruby
class WordsComparator
    def initialize
        @words_to_adjacent = {}
    end

    def adjacent?(word1, word2)
        words = Set.new([word1, word2])
        return @words_to_adjacent[words] if @words_to_adjacent[words]

        word1_size = word1.size
        word2_size = word2.size
        return false if word1_size != word2_size

        diff = 0
        word1_size.times do |i|
            next if word1[i] == word2[i]

            diff += 1
            break if diff >= 2
        end
        @words_to_adjacent[words] = diff == 1
    end
end

# @param {String} begin_word
# @param {String} end_word
# @param {String[]} word_list
# @return {Integer}
def ladder_length(begin_word, end_word, word_list)
    not_existed = 0

    return not_existed unless word_list.include?(end_word)

    word_to_visited = { begin_word => true }
    word_list.each do |word|
        word_to_visited[word] = false
    end

    next_words = Queue.new
    next_words.enq(begin_word)
    result = 1
    word_comparator = WordsComparator.new
    while !next_words.empty?
        next_words.size.times do
            word = next_words.deq
            return result if word == end_word

            word_list.each do |word_in_list|
                next if word_to_visited[word_in_list] || !word_comparator.adjacent?(word, word_in_list)

                word_to_visited[word_in_list] = true
                next_words << word_in_list
            end
        end
        result += 1
    end
    not_existed
end
```

`adjacent?`の高速化を試みたが、よくよく考えると`word_to_visited[word_in_list]`で弾かれるので、同じ組み合わせのwordが比較されることはない。
それどころかSetの生成コストが高くて、元のコードよりも遅くなっている…

- https://github.com/tarinaihitori/leetcode/pull/20

step1でQueueを利用していたが、使わなくても解ける。
RubyのQueueはおもにスレッドプログラミングを目的としているので、今回の処理のために使うのは微妙かも。
ref: https://docs.ruby-lang.org/ja/latest/class/Thread=3a=3aQueue.html

```ruby
# @param {String} begin_word
# @param {String} end_word
# @param {String[]} word_list
# @return {Integer}
def ladder_length(begin_word, end_word, word_list)
    not_existed = 0

    word_set = Set.new(word_list)
    return not_existed unless word_set.include?(end_word)

    word_to_visited = { begin_word => true }
    word_list.each do |word|
        word_to_visited[word] = false
    end

    words = [begin_word]
    result = 1
    while !words.empty?
        next_words = []
        words.size.times do
            word = words.pop
            return result if word == end_word

            word.size.times do |i|
                ("a".."z").each do |alphabet|
                    adjacent = word.dup
                    adjacent[i] = alphabet
                    
                    next if !word_set.include?(adjacent) || word_to_visited[adjacent] == true
                    word_to_visited[adjacent] = true
                    next_words << adjacent
                end
            end
        end
        words = next_words
        result += 1
    end
    not_existed
end
```

同一の長さに制限して置換のみを許容する編集距離のことをハミング距離(hamming distance)というらしい。

- https://github.com/tarinaihitori/leetcode/pull/20

wordListを全部舐めて、一文字をワイルドカードにしたキーと元の文字のリストのHashTable（例：`{ "a*c" => [abc] }`）を作っておくのはわかりやすいと思った。

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

文字の長さをM、word_listの長さをNとすると、時間計算量はO((M^2)*N)でstep1と同様だが、定数倍部分でstep1よりも改善している。
空間計算量はキーの個数が O(M^2)* N になるので((M^2)*N)
