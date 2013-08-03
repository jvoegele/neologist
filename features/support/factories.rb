FactoryGirl.define do
  factory :user do |f|
    f.username 'testuser'
  end

  factory :quip do |f|
    f.association :user
    f.content 'Test quip content'
  end
end
