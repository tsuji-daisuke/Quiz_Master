class Question < ActiveRecord::Base
  has_many :results, dependent: :destroy

  validates :content, presence: true
  validates :answer, presence: true

  before_create :trim

  private
  def trim
    self.answer.strip!
  end

end
