FactoryGirl.define do
  factory :version do
    title "Ruby On Rails"
    content "Convention over Configuration"
    blog { FactoryGirl.build(:blog) }
  end
end
