class EmailNotifier < ActiveRecord::Base
  has_secure_token :verification_token
  validates_format_of :email, with: Devise::email_regexp
end
