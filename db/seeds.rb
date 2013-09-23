# coding: utf-8;

def create_category(title)
  Category.where(title: title).first_or_create!
end

def create_user(user_hash)
  u = User.where(email: user_hash[:email])
      .first_or_create!(name: user_hash[:name],
                        password: user_hash[:password],
                        password_confirmation: user_hash[:password])
  u.update_attribute(:admin, user_hash[:admin])
  u.category_ids = Category.where('"categories"."title" IN (?)', user_hash[:categories]).pluck(:id)
end

create_category('Политика')
create_category('Спорт')
create_category('Культура')

create_user(name: 'Александр Антонов', email: 'kaburbundokel11g@inbox.ru', password: 'secret', admin: true, categories: %w(Политика Спорт))
create_user(name: 'Михаил Кечинов', email: 'sam@mkechinov.ru', password: 'secret', admin: true, categories: %w(Политика))
create_user(name: 'Антон Жаворонков', email: 'anton@mkechinov.ru', password: 'secret', admin: true, categories: %w(Спорт Культура))
create_user(name: 'Anonymous', email: 'anonymous@anonymous.ru', password: 'secret', admin: false, categories: %w(Политика Культура))
