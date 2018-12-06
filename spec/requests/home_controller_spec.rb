require 'rails_helper'

describe HomeController do
  describe 'Get#check' do
    context 'Webアプリで結果表示後にリロードしたとき' do
      it 'topページが表示されること' do
        get '/check'
        expect(response).to render_template :top
      end
    end
  end
end


