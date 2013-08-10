FactoryGirl.define do
  factory :user do |f|
    f.username 'testuser'
    f.password 'fake'
    f.password_confirmation 'fake'
  end

  factory :quip do |f|
    f.association :user
    f.content 'Test quip content'
  end
end
