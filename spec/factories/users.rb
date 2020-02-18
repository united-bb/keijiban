FactoryBot.define do
  factory :user do
    name { 'テストユーザ'}
    password { 'password'}
    password_confirmation { 'password'}
  end
end
