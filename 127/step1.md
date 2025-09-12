# step1 何も見ずに解く
あるwordから1文字変更したadjacentの変換はノード上の移動と同じなのでこれはグラフの問題に帰着することができる。
wordの先頭から最後の文字までを、a-zに変更した文字がword_listに含まれていれば、移動可能なwordであると考えられる。
今回は最短距離を求めれば良いので幅優先探索を行う。
word_listはSetに入れておけば含まれるかどうかの計算量はO(1)
文字の長さをM、word_listの長さをNとすると、~~時間計算量はO(M*N*26)(26はa-zのアルファベットの数)で、定数を無視するとO(M*N)~~
~~MとNの長さの最大値は10, 5*10^3なので1秒以内に終わる。~~
↑
後で間違いだと気づいた。`word.dup`をループの中で実行しているので、時間計算量はO((M^2)*N)になりそう。
空間計算量はO(M*N)

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

    words = Queue.new
    words.enq(begin_word)
    result = 1
    while !words.empty?
        words.size.times do
            word = words.deq
            return result if word == end_word

            word.size.times do |i|
                ("a".."z").each do |alphabet|
                    adjacent = word.dup
                    adjacent[i] = alphabet
                    
                    next if !word_set.include?(adjacent) || word_to_visited[adjacent] == true
                    word_to_visited[adjacent] = true
                    words << adjacent
                end
            end
        end
        result += 1
    end
    not_existed
end
```

あるwordに隣接する（＝一文字違いの）wordを探す時に、word_listの先頭から見て隣接しているかをチェックする方法も浮かんだが、間に合いそうになかったのでやめた。
以下のような感じ。

(Time Limit Exceeded)

```ruby
def adjacent?(word1, word2)
    word1_size = word1.size
    word2_size = word2.size
    return false if word1_size != word2_size

    diff = 0
    word1_size.times do |i|
        next if word1[i] == word2[i]

        diff += 1
    end
    diff == 1
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
    while !next_words.empty?
        next_words.size.times do
            word = next_words.deq
            return result if word == end_word

            word_list.each do |word_in_list|
                next if word_to_visited[word_in_list] || !adjacent?(word, word_in_list)

                word_to_visited[word_in_list] = true
                next_words << word_in_list
            end
        end
        result += 1
    end
    not_existed
end
```
やはりこの方法だと時間以内に解けなかった。
