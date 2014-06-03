FactoryGirl.define do

  factory :cohort do
    start_date Date.today
    end_date  Date.today + 90
    course factory: :course
    location factory: :location
  end

end