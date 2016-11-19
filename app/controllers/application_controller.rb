class ApplicationController < ActionController::Base
  # テストだもん
  protect_from_forgery with: :null_session
end
