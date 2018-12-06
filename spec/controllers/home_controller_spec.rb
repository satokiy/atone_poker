require 'rails_helper'

describe HomeController do
  describe 'Get#top' do
    it 'リクエストは200 OKとなること' do
      expect(response.status).to eq 200
    end
    it '初期画面では「カードを入力してください」と表示されていること' do
      get :top
      expect(controller.instance_variable_get('@errors')).to eq [{message: 'カードを入力してください'}]
    end
  end

  describe 'Post#check' do
    context '空入力の場合' do
      let(:params) {{cards: ' '}}
      it 'リクエストは200 OKとなること' do
        post :check, params
        expect(response.status).to eq 200
      end
      it 'topページを再表示すること' do
        post :check, params
        expect(response).to render_template :top
      end
      it '@errorsが「カードが入力されていません。」であること' do
        post :check, params
        expect(controller.instance_variable_get('@errors')).to eq [{message: 'カードが入力されていません。'}]
      end
    end
    context '異常値の入力の場合' do
      let(:params1) {{cards: '山田 悟生'}}
      let(:params2) {{cards: 'D4 T5 S5 H7 H3'}}
      it 'リクエストは200 OKとなること' do
        post :check, params1
        expect(response.status).to eq 200
      end
      it 'topページを再表示すること' do
        post :check, params1
        expect(response).to render_template :top
      end
      it '@errorsに値が入っていること' do
        post :check, params1
        expect(controller.instance_variable_get('@errors')).to be_truthy
      end
    end
    context '正常値の入力の場合' do
      let(:params1) {{cards: 'D4 S5 H7 H3 S10'}}
      let(:params2) {{cards: 'D5 S5 H5 H10 S10'}}
      it 'リクエストは200 OKとなること' do
        post :check, params1
        expect(response.status).to eq 200
      end
      it 'topページを再表示すること' do
        post :check, params1
        expect(response).to render_template :top
      end
      it '@roleに値が正しい結果（ハイカード）が入っていること' do
        post :check, params1
        expect(controller.instance_variable_get('@role')).to eq 'ハイカード'
      end
      it '@roleに値が正しい結果（フルハウス）が入っていること' do
        post :check, params2
        expect(controller.instance_variable_get('@role')).to eq 'フルハウス'
      end
    end
  end
end
