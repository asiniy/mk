namespace :posts do
  desc "Pick a random user as the winner"
  task random_clones: :environment do
    total_posts = Post.all

    100.times do
      post = total_posts.sample
      new_post = post.dup
      new_post.category_ids = post.category_ids
      new_post.save!
    end

    puts Post.count
  end
end
