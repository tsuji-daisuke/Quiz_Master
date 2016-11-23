require 'rails_helper'
describe "QuestionsController" do
  def json
    @json ||= ActiveSupport::JSON.decode(response.body) unless response.nil?
  end

  describe "一覧" do
    let(:questions) { json }
    describe "通常" do
      before do
        5.times do |n|
          FactoryGirl.create(:question)
        end
        get '/api/v1/questions.json'
      end
      it "一覧が取得でき、jsonとDBの内容が等しい" do
        expect(response).to be_success
        expect(response.status).to eq 200
        expect(questions.size).to eq 5
        questions.each do |q|
          data_q = Question.find(q['id'])
          expect(q['content']).to eq data_q.content
          expect(q['answer']).to eq data_q.answer
        end
      end
    end
    describe "データ無し" do
      before do
        get '/api/v1/questions.json'
      end
      it "データが無くてもエラーにならない" do
        expect(response).to be_success
        expect(response.status).to eq 200
        expect(questions.size).to eq 0
      end
    end
  end

  describe "作成" do
    let(:prm) { {question: {content: 'NEW-QUESTION', answer: 'NEW-ANSWER'}}.as_json }
    let(:question) { json }
    describe "通常" do
      before do
        5.times do |n|
          FactoryGirl.create(:question)
        end
        post '/api/v1/questions.json', prm
      end
      it "Questionが作成できている" do
        expect(response).to be_success
        expect(response.status).to eq 201
        expect(Question.count).to eq 6
        data_q = Question.where(content: prm['question']['content']).first
        expect(data_q.content).to eq prm['question']['content']
        expect(data_q.answer).to eq prm['question']['answer']
      end
      it "レスポンスは作成したデータ" do
        expect(question['content']).to eq 'NEW-QUESTION'
        expect(question['answer']).to eq 'NEW-ANSWER'
      end
    end
    describe "質問が無ければNG" do
      let(:prm) { {question: {answer: 'NEW-ANSWER'}}.as_json }
      before do
        post '/api/v1/questions.json', prm
      end
      it "エラー" do
        expect(response.status).not_to eq 201
        expect(Question.count).to eq 0
      end
    end
    describe "答えが無くてもNG" do
      let(:prm) { {question: {content: 'NEW-QUESTION'}}.as_json }
      before do
        post '/api/v1/questions.json', prm
      end
      it "エラー" do
        expect(response.status).not_to eq 201
        expect(Question.count).to eq 0
      end
    end
  end

  describe "削除" do
    describe "通常" do
      before do
        5.times do |n|
          FactoryGirl.create(:question)
        end
        @prm = Question.find(Question.pluck(:id).sample)
        delete "/api/v1/questions/#{@prm[:id]}.json"
      end
      it "該当のQuestionが削除されている" do
        expect(response).to be_success
        expect(response.status).to eq 204
        expect { Question.find(@prm[:id]) }.to raise_error(ActiveRecord::RecordNotFound)
      end
      it "他のQuestionは削除されていない" do
        expect(Question.count).to eq 4
      end
    end
    describe "該当のQuestionがない" do
      it "エラー" do
        expect { delete "/api/v1/questions/:1.json" }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "更新" do
    let(:questions) { json }
    describe "通常" do
      before do
        5.times do |n|
          FactoryGirl.create(:question)
        end
        q = Question.find(Question.pluck(:id).sample)
        @prm = {question: {id: q.id, content: 'UPDATED-QUESTION', answer: 'UPDATED-ANSWER'}}
        @before_datas = Question.all
        put "/api/v1/questions/#{@prm[:question][:id]}.json", @prm
      end
      it "該当のQuestionが更新されている" do
        expect(response).to be_success
        expect(response.status).to eq 200
        expect(Question.count).to eq 5
        data_q = Question.find(@prm[:question][:id])
        expect(data_q.content).to eq @prm[:question][:content]
        expect(data_q.answer).to eq @prm[:question][:answer]
      end
      it "他のQuestionには変化がない" do
        datas = Question.where.not(id: @prm[:question][:id])
        datas.each do |data|
          before = @before_datas.find(data.id)
          expect(data.content).to eq before.content
          expect(data.answer).to eq before.answer
        end
      end
    end
    describe "質問が無ければNG" do
      before do
        5.times do |n|
          FactoryGirl.create(:question)
          @before = Question.find(Question.pluck(:id).sample)
          @prm = {question: {id: @before.id, content: '', answer: 'UPDATED-ANSWER'}}
          put "/api/v1/questions/#{@prm[:question][:id]}.json", @prm
        end
      end
      it "エラー" do
        expect(response.status).to eq 422
        expect(Question.find(@prm[:question][:id]).content).to eq @before.content
      end
    end
    describe "答えが無ければNG" do
      before do
        5.times do |n|
          FactoryGirl.create(:question)
          @before = Question.find(Question.pluck(:id).sample)
          @prm = {question: {id: @before.id, content: 'UPDATED-QUESTION', answer: ''}}
          put "/api/v1/questions/#{@prm[:question][:id]}.json", @prm
        end
      end
      it "エラー" do
        expect(response.status).to eq 422
        expect(Question.find(@prm[:question][:id]).answer).to eq @before.answer
      end
    end
    describe "該当のQuestionがない" do
      before do
        @prm = {question: {id: 1, content: 'UPDATED-QUESTION', answer: 'UPDATED-ANSWER'}}
      end
      it "エラー" do
        expect { put "/api/v1/questions/:1.json", @prm }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end


end

