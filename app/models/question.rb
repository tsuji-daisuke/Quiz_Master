class Question < ActiveRecord::Base
  validates :content, presence: true
  validates :answer, presence: true
end
