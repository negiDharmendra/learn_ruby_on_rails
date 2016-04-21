FactoryGirl.define do
  factory :blog do
    title "Ruby On Rails"
    content "Convention over Configurations"
    user { FactoryGirl.build(:user) }
  end

end