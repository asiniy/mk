class UserMailer < ActionMailer::Base
  default from: "no_reply@mkechinov.herokuapp.com"

  def post_published(post_id)
    @post = Post.find(post_id)
    mail to: @post.user.email, subject: "Ваша статья подтверждена!"
  end

  def post_declined(post_id)
    @post = Post.find(post_id)
    mail to: @post.user.email, subject: "Ваша статья отклонена!"
  end

  def category_subscription(user_id, post_id, category_ids)
    @user = User.find(user_id)
    @post = Post.find(post_id)
    @categories = Category.find(category_ids)
    mail to: @user.email, subject: "Опубликована новая статья \"#{@post.heading}\" в #{Russian.p(@categories, 'категории', 'категориях')} #{@categories.join(', ')}"
  end
end
