FactoryGirl.define do
  factory :user do |f|
    f.full_name 'Test User'
    f.email 'test@user.com'
    f.username 'testuser'
    f.password '______'
    f.password_confirmation '______'
  end

  factory :quip do |f|
    f.association :user
    f.content 'Test quip content'
  end
end

def create_quips(user, count)
  (1..count).reduce([]) do |memo, n|
    quip = user.new_quip(content: "#{user.username}: %06d" % n)
    quip.save
    yield(quip, n) if block_given?
    memo << quip
  end
end
