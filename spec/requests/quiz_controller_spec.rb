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

  describe "数字だけ" do
    let(:result) { json }
    before do
      @q = Question.create(content: 'ONLY-NUMBER', answer: '26')
    end
    describe "正解" do
      before do
        prm = {result: {question_id: @q.id, content: '26'}}.as_json
        post '/api/v1/quiz.json', prm
      end
      it "レスポンスが期待値通り" do
        expect(response).to be_success
        expect(response.status).to eq 201
        expect(result).not_to eq nil
        expect(result['judgement']).to eq 'OK! Go to next Question!'
      end
      it "結果のレコードが作成されている" do
        r = Result.find(result['id'])
        expect(r.content).to eq '26'
        expect(r.judgement).to eq 'OK! Go to next Question!'
      end
    end
    describe "不正解" do
      before do
        prm = {result: {question_id: @q.id, content: '25'}}.as_json
        post '/api/v1/quiz.json', prm
      end
      it "レスポンスが期待値通り" do
        expect(response).to be_success
        expect(response.status).to eq 201
        expect(result).not_to eq nil
        expect(result['judgement']).to eq 'No!... Please retry.'
      end
      it "結果のレコードが作成されている" do
        r = Result.find(result['id'])
        expect(r.content).to eq '25'
        expect(r.judgement).to eq 'No!... Please retry.'
      end
    end
  end

  describe "単語" do
    let(:result) { json }
    before do
      @q = Question.create(content: 'ONLY-WORD', answer: 'snow')
    end
    describe "正解" do
      before do
        prm = {result: {question_id: @q.id, content: 'snow'}}.as_json
        post '/api/v1/quiz.json', prm
      end
      it "レスポンスが期待値通り" do
        expect(response).to be_success
        expect(response.status).to eq 201
        expect(result).not_to eq nil
        expect(result['judgement']).to eq 'OK! Go to next Question!'
      end
      it "結果のレコードが作成されている" do
        r = Result.find(result['id'])
        expect(r.content).to eq 'snow'
        expect(r.judgement).to eq 'OK! Go to next Question!'
      end
    end
    describe "不正解" do
      before do
        prm = {result: {question_id: @q.id, content: 'rain'}}.as_json
        post '/api/v1/quiz.json', prm
      end
      it "レスポンスが期待値通り" do
        expect(response).to be_success
        expect(response.status).to eq 201
        expect(result).not_to eq nil
        expect(result['judgement']).to eq 'No!... Please retry.'
      end
      it "結果のレコードが作成されている" do
        r = Result.find(result['id'])
        expect(r.content).to eq 'rain'
        expect(r.judgement).to eq 'No!... Please retry.'
      end
    end
  end

  describe "文" do
    let(:result) { json }
    before do
      @q = Question.create(content: 'SENTENCE', answer: 'I have many books.')
    end
    describe "正解" do
      before do
        prm = {result: {question_id: @q.id, content: 'I have many books.'}}.as_json
        post '/api/v1/quiz.json', prm
      end
      it "レスポンスが期待値通り" do
        expect(response).to be_success
        expect(response.status).to eq 201
        expect(result).not_to eq nil
        expect(result['judgement']).to eq 'OK! Go to next Question!'
      end
      it "結果のレコードが作成されている" do
        r = Result.find(result['id'])
        expect(r.content).to eq 'I have many books.'
        expect(r.judgement).to eq 'OK! Go to next Question!'
      end
    end
    describe "不正解" do
      before do
        prm = {result: {question_id: @q.id, content: "I don't have books at all!"}}.as_json
        post '/api/v1/quiz.json', prm
      end
      it "レスポンスが期待値通り" do
        expect(response).to be_success
        expect(response.status).to eq 201
        expect(result).not_to eq nil
        expect(result['judgement']).to eq 'No!... Please retry.'
      end
      it "結果のレコードが作成されている" do
        r = Result.find(result['id'])
        expect(r.content).to eq "I don't have books at all!"
        expect(r.judgement).to eq 'No!... Please retry.'
      end
    end
  end

  describe "数字と英語読み数字混じりの文" do
    let(:result) { json }
    before do
      @q = Question.create(content: 'SENTENCE-CONTAINS-NUMBER_AND_WORDS', answer: 'I have reserved three tables for Dec. 30.')
    end
    describe "正解" do
      before do
        prm = {result: {question_id: @q.id, content: 'I have reserved three tables for Dec. 30.'}}.as_json
        post '/api/v1/quiz.json', prm
      end
      it "レスポンスが期待値通り" do
        expect(response).to be_success
        expect(response.status).to eq 201
        expect(result).not_to eq nil
        expect(result['judgement']).to eq 'OK! Go to next Question!'
      end
      it "結果のレコードが作成されている" do
        r = Result.find(result['id'])
        expect(r.content).to eq 'I have reserved three tables for Dec. 30.'
        expect(r.judgement).to eq 'OK! Go to next Question!'
      end
    end
    describe "不正解" do
      before do
        prm = {result: {question_id: @q.id, content: 'I have reserved seven tables for Dec. 30'}}.as_json
        post '/api/v1/quiz.json', prm
      end
      it "レスポンスが期待値通り" do
        expect(response).to be_success
        expect(response.status).to eq 201
        expect(result).not_to eq nil
        expect(result['judgement']).to eq 'No!... Please retry.'
      end
      it "結果のレコードが作成されている" do
        r = Result.find(result['id'])
        expect(r.content).to eq 'I have reserved seven tables for Dec. 30'
        expect(r.judgement).to eq 'No!... Please retry.'
      end
    end
  end

  describe "日本語" do
    let(:result) { json }
    before do
      @q = Question.create(content: 'JAPANESE', answer: 'HUNTER×HUNTERです')
    end
    describe "正解" do
      before do
        prm = {result: {question_id: @q.id, content: 'HUNTER×HUNTERです'}}.as_json
        post '/api/v1/quiz.json', prm
      end
      it "レスポンスが期待値通り" do
        expect(response).to be_success
        expect(response.status).to eq 201
        expect(result).not_to eq nil
        expect(result['judgement']).to eq 'OK! Go to next Question!'
      end
      it "結果のレコードが作成されている" do
        r = Result.find(result['id'])
        expect(r.content).to eq 'HUNTER×HUNTERです'
        expect(r.judgement).to eq 'OK! Go to next Question!'
      end
    end
    describe "不正解" do
      before do
        prm = {result: {question_id: @q.id, content: 'レベルEです'}}.as_json
        post '/api/v1/quiz.json', prm
      end
      it "レスポンスが期待値通り" do
        expect(response).to be_success
        expect(response.status).to eq 201
        expect(result).not_to eq nil
        expect(result['judgement']).to eq 'No!... Please retry.'
      end
      it "結果のレコードが作成されている" do
        r = Result.find(result['id'])
        expect(r.content).to eq 'レベルEです'
        expect(r.judgement).to eq 'No!... Please retry.'
      end
    end
  end

end


