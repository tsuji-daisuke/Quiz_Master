class Result < ActiveRecord::Base
  belongs_to :question

  validates :question_id, presence: true
  validates :content, presence: true

  before_create :trim, :judge

  private
  def trim
    self.content.strip!
  end

  def judge
    q = Question.find(question_id)
    if q.present? && self.content == q.answer
      self.judgement = 'OK! Go to next Question!'
    else
      self.judgement = 'No!... Please retry.'
    end
  end

end
