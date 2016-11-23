require 'rails_helper'
describe "QuizController" do
  def json
    @json ||= ActiveSupport::JSON.decode(response.body) unless response.nil?
  end

  describe "出題" do
    let(:question) { json }
    describe "通常" do
      before do
        5.times do |n|
          FactoryGirl.create(:question)
        end
        get '/api/v1/quiz.json'
      end
      it "ランダムでどれかのQuestionが取得できる" do
        expect(response).to be_success
        expect(response.status).to eq 200
        expect(question).not_to eq nil
        data = Question.find(question['id'])
        expect(question['content']).to eq data.content
        expect(question['answer']).to eq data.answer
      end
    end
    describe "データ無し" do
      before do
        get '/api/v1/quiz.json'
      end
      it "データが無い場合でも自動でサンプルQuestionが作られる" do
        expect(response).to be_success
        expect(response.status).to eq 200
        expect(question).not_to eq nil
        data = Question.find(question['id'])
        expect(question['content']).to eq data.content
        expect(question['answer']).to eq data.answer
      end
    end
  end


end


