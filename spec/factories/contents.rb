FactoryGirl.define do
  factory :content do
    title 'Title of post'
    body 'Body of the Post'
    user
  end
end