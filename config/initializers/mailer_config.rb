ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  address: ENV['SMTP_ADDRESS'],
  domain: ENV['SMTP_DOMAIN'],
  port: '587',
  user_name: ENV['SMTP_USERNAME'],
  password:  ENV['SMTP_PASSWORD'],
  authentication: :plain,
}
