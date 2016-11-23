class Api::V1::QuizController < Api::V1::BaseController
  def show
    if Question.count != 0
      respond_with Question.find(Question.pluck(:id).sample)
    else
      respond_with Question.create(content: 'How many letters are there in the English alphabet?', answer: '26')
    end
  end

  def post
    respond_with Result.create(result_params), location: -> { api_v1_quiz_path }
  end

  private
  def question_params
    params.require(:question).permit(:id, :content, :answer)
  end

  private
  def result_params
    params.require(:result).permit(:id, :question_id, :content, :judgement)
  end

end