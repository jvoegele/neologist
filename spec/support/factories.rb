FactoryGirl.define do
  factory :user do |f|
    f.username 'testuser'
    f.password '______'
    f.password_confirmation '______'
  end

  factory :quip do |f|
    f.association :user
    f.content 'Test quip content'
  end
end
