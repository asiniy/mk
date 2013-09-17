# coding: utf-8;

def create_user(user_hash)
  User.where(email: user_hash[:email])
    .first_or_create!(name: user_hash[:name],
                      password: user_hash[:password],
                      password_confirmation: user_hash[:password],
                      admin: user_hash[:admin])
end

def create_category(title)
  Category.where(title: title).first_or_create!
end

create_user(name: 'Александр Антонов', email: 'kaburbundokel11g@inbox.ru', password: 'secret', admin: true)
create_user(name: 'Михаил Кечинов', email: 'sam@mkechinov.ru', password: 'secret', admin: true)
create_user(name: 'Антон Жаворонков', email: 'anton@mkechinov.ru', password: 'secret', admin: true)
create_user(name: 'Anonymous', email: 'anonymous@anonymous.ru', password: 'secret', admin: false)

create_category('Политика')
create_category('Спорт')
create_category('Культура')
