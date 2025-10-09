# step1 何も見ずに解く
sの文字の先頭をiとする。tを先頭から見ていき、iの文字があればi += 1に更新する。
iが末尾までいけばsはtのsubsequenceと言える。
tの長さをNとすると時間計算量はO(N)となる。
空間計算量亜はO(1)
Nの最大値が10^4なので1秒以内に間に合う。

```ruby
# @param {String} s
# @param {String} t
# @return {Boolean}
def is_subsequence(s, t)
    return true if s.size.zero?

    last_subsequence_index = 0
    t.each_char do |char|
        last_subsequence_index += 1 if s[last_subsequence_index] == char
        return true if last_subsequence_index == s.size
    end
    false
end
```

Followupについて考える。
今のコードだと、sがtに存在しない文字を含んでいてもtを最後まで見るので効率が悪い。
tの文字をSetにしておいて存在しない文字を含んでいたらfalseを返すと、存在しない文字を前の方に含んでいるのを早めに弾けて速くなる可能性がある。

```ruby
# @param {List[String]} s_list
# @param {String} t
# @return {Boolean}
def is_subsequence(strs, original_str)
    original_str_set = Set.new
    original_str.each_char do |char|
      original_str_set << char
    end

    is_subsequence_helper = lambda do |str|
      return true if str.size.zero?

      last_subsequence_index = 0
      original_str.each_char do |char|
          return false unless original_str_set.include?(str[last_subsequence_index])
          last_subsequence_index += 1 if str[last_subsequence_index] == char
          return true if last_subsequence_index == str.size
      end
      false
    end

    strs.each_with_object({}) {|str, result| result[str] = is_subsequence_helper.call(str) }
end

is_subsequence(["abc", "ab", "zahbgdc"], "ahbgdc")
# => {"abc"=>true, "ab"=>true, "zahbgdc"=>false}
```
