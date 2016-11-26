class Api::V1::QuestionsController < Api::V1::BaseController

  def index
    respond_with Question.all.order('id DESC')
  end

  def create
    respond_with :api, :v1, Question.create(question_params)
  end

  def destroy
    respond_with Question.destroy(params[:id])
  end

  def update
    q = Question.find(params['id'])
    q.update_attributes(question_params)
    respond_with q, json: q
  end

  private
  def question_params
    params.require(:question).permit(:id, :content, :answer)
  end


end
