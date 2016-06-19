class NotificationsMailer < ApplicationMailer

  def failed(mailing_list, monitor, test_result)
    @monitor = monitor
    @test_result = test_result
    subject = "#{@monitor[:monitor]} FAILED"

    mail to: mailing_list, subject
  end

  def resolved(mailing_list, monitor, test_result)
    @monitor = monitor
    @test_result = test_result
    subject = "ISSUE RESOLVED #{@monitor[:monitor]} PASSED"

    mail to: mailing_list, subject
  end
end
