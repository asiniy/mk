class UserMailer < ActionMailer::Base
  default from: "no_reply@portalchik.com"

  def post_published(post_id)
    @post = Post.find(post_id)
    mail to: @post.user.email, subject: "Ваш пост опубликован!"
  end
end
