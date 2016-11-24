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
    split_answers = []
    split_contents = []
    q = Question.find(question_id)
    q.answer.split(/[\s,]/).each do |word|
      if word =~ /\d+/
        split_answers.push word.to_i.to_en
      else
        split_answers.push word
      end
    end
    self.content.split(/[\s,]/).each do |word|
      if word =~ /\d+/
        split_contents.push word.to_i.to_en
      else
        split_contents.push word
      end
    end
    if split_answers.join(' ').gsub(' ', '') == split_contents.join(' ').gsub(' ', '')
      self.judgement = 'OK! Go to next Question!'
    else
      self.judgement = 'No!... Please retry.'
    end
  end

end
