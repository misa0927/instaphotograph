class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_picture.subject
  #
  def sendmail_picture(picture)
    @picture = picture

    mail to:"misatatesawa@gmail.com",
      subject: '【 Instagraph 】写真が投稿されました！'
  end

  def sendmail_contact(contact)
    @contact = contact

    mail to:@contact.email,
         subject: '【 Instagraph 】お問い合わせが完了しました'
  end

end
