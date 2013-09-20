class UserMailer < ActionMailer::Base
  default from: "no_reply@mkechinov.herokuapp.com"

  def post_published(post_id)
    @post = Post.find(post_id)
    mail to: @post.user.email, subject: "Ваша статья подтверждена!"
  end

  def post_declined(post_id)
    @post = Post.find(post_id)
    mail_to: @post.user.email, subject: "Ваша статья отклонена!"
  end
end
