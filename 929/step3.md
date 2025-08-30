# step3 3回続けて10分以内に書いてエラーを出さなければOKとする
```ruby
# @param {String[]} emails
# @return {Integer}
def num_unique_emails(emails)
    valid_email_pattern = /\A[a-z][a-z.+]*@[a-z][a-z.+]*\.com\z/
    unique_canonicalized_emails = Set.new

    emails.each do |email|
        next unless valid_email_pattern.match?(email)

        canonicalized_local, canonicalized_domain = email.split("@")
        canonicalized_local = canonicalized_local.split("+").first.delete(".")
        unique_canonicalized_emails.add("#{canonicalized_local}@#{canonicalized_domain}")
    end

    unique_canonicalized_emails.count
end
```
