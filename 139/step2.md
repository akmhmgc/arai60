# step2 他の方の解答を見る
## Bottom up DP
https://github.com/h1rosaka/arai60/pull/41/files#diff-25f1226927fe56c505f4cbf2124534215d66f3c2ca0decf160a04dc095c93e83R83-R101

```ruby
# @param {String} str
# @param {String[]} word_dict
# @return {Boolean}
def word_break(str, word_dict)
    str_size = str.size
    return true if str_size.zero?
    return false if word_dict.size.zero?

    segmented = Array.new(str_size + 1, false)
    segmented[0] = true
    1.upto(str_size + 1).each do |end_index|
        word_dict.each do |word|
            next if end_index < word.size

            if segmented[end_index - word.size] && str[(end_index - word.size)...end_index] == word
                segmented[end_index] = true
                break
            end
        end
    end
    segmented.last
end
```

indexがわかりにくくてミスしそう。

## ローリングハッシュ

```ruby
# @param {String} str
# @param {String[]} word_dict
# @return {Boolean}
def word_break(str, word_dict)
  return true if str.empty?
  str_size = str.size

  mod  = 1_000_000_007
  base = 29

  byte_of = ->(byte) { byte - 96 }

  prefix_hashes = Set.new
  word_hashes   = Set.new

  word_dict.each do |w|
    hash = 0
    w.each_byte do |b|
      hash = (hash * base + byte_of.call(b)) % mod
      prefix_hashes.add(hash)
    end
    word_hashes.add(hash)
  end

  reachable = Array.bnew(str_size, false)

  (0...str_size).each do |i|
    next if i > 0 && !reachable[i - 1]

    hash = 0
    (i...str_size).each do |j|
      hash = (hash * base + byte_of.call(str.getbyte(j))) % mod

      break unless prefix_hashes.include?(hash)

      if word_hashes.include?(hash)
        reachable[j] = true
        return true if j == str_size - 1
      end
    end
  end

  reachable[str_size - 1]
end
```

ハッシュの衝突が怖いので実際のプロダクションに導入したくないと感じた。
