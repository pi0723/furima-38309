FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end

    nickname               { Faker::Name.name }
    email                  { Faker::Internet.free_email }
    password               { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation  { password }
    last_name              { person.last }
    first_name             { person.first }
    read_last              { person.last.katakana }
    read_first             { person.first.katakana }
    birthday               { Faker::Date.birthday }
  end
end
