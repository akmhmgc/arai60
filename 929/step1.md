# step1 何も見ずに解く
与えられたメールアドレスを正規化してSetに入れれば良い。
メールアドレスの文字列の長さをM、配列の長さをNとすると計算量はO(NM)
文字列の長さ、配列の長さはともに100以下なので1秒以内に終わることを期待すると余裕で間に合う。
空間計算量はO(N*M)

次に、不正なメールアドレスについて考える。
問題文から読み取る限りでは連続しないとは書いていないので`.`や`+`の連続は許容する（実際のメールアドレスとは違うが）
不正な入力があった場合の処理は以下が考えられる。
- 正常終了する
  - 不正な入力をスキップする
  - 不正な入力も出力に含める
- 異常終了する

例えば、マーケティングツールの試作の効果をメールアドレスではなくユーザー単位で確認したい。
計測の処理を日次のバッチで行っている、とかであれば不正な入力をスキップして良いだろう。
異常終了させたいユースケースは思いつかなかった。前段でメールアドレスが確実にクレンジングされている時とか、外部からの入力ではない時とか？

```ruby
# @param {String[]} emails
# @return {Integer}
def num_unique_emails(emails)
    valid_email_pattern = /\A[a-z][a-z.+]*@[a-z][a-z.+]*\.com\z/
    unique_normalized_emails = Set.new

    emails.each do |email|
        next unless valid_email_pattern.match?(email)

        normalized_local, normalized_domain = email.split("@")
        normalized_local = normalized_local.split("+").first.delete(".")
        unique_normalized_emails.add("#{normalized_local}@#{normalized_domain}")
    end

    unique_normalized_emails.count
end
```

