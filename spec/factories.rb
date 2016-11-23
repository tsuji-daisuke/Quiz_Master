FactoryGirl.define do

  factory :question do
    sequence(:content) {|n| "QUESTION-#{n}"}
    sequence(:answer) {|n| "ANSWER-#{n}"}
  end

end
