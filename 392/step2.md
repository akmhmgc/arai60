# step2 他の方の解答を見る
## LCS
https://github.com/shining-ai/leetcode/pull/57

```ruby
# @param {String} s
# @param {String} t
# @return {Boolean}
def is_subsequence(s, t)
    lcs_sizes = Array.new(s.size + 1) { Array.new(t.size + 1, 0) }
    s.size.times do |i|
        t.size.times do |j|
            if s[i] == t[j]
                lcs_sizes[i + 1][j + 1] = lcs_sizes[i][j] + 1
            else
                lcs_sizes[i + 1][j + 1] = [lcs_sizes[i + 1][j], lcs_sizes[i][j + 1]].max
            end
        end
    end
    lcs_sizes.last.last == s.size
end
```

## 正規表現
```ruby
# @param {String} s
# @param {String} t
# @return {Boolean}
def is_subsequence(s, t)
  pattern = ""
  s.each_char do |c|
    pattern += ".*" + Regexp.escape(c)
  end
  t.match?(/^#{pattern}/)
end
```

エスケープしておかないとReDos攻撃の危険があるので使うのは怖い。


## Follow up
tの文字とindexesのハッシュテーブル（char_to_indexesとする）を持っておいて、
sに含まれる文字がtの中で前から順に含まれているかどうかをチェックしていけば良い。

時間計算量はsの長さをMとするとO(M*logN)となる

```ruby
def is_subsequence(s, t)
    return true if s.empty?
    
    t_char_to_indexes = Hash.new { |h, k| h[k] = [] }
    t.each_char.with_index { |ch, i| t_char_to_indexes[ch] << i }

    last_matched_index = -1
    s.each_char do |ch|
        indexes = t_char_to_indexes[ch]
        return false unless indexes

        next_index = indexes.bsearch { |pos| pos > last_matched_index }
        return false unless next_index

        last_matched_index = next_index
    end
    true
end
```
