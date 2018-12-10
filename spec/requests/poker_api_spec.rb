require 'rails_helper'

describe 'POST /api/ver1/poker_api' do
  describe 'PokerApi' do
    let(:headers) {{'Content-Type' => 'application/json', 'Accept' => 'application/json'}}
    # let(:url) {'/api/ver1/poker_api'}
    let(:params1) {{
        "cards": [
            "山田 悟生",
            "H9 C9 S9 H2 C2",
            "C13 D12 C11 H8 H7"]
    }}
    let(:params2) {{
        "cards": [
            "H13 H12 H11 H9 H7",
            "H9 C9 S9 H2 C2",
            "C13 D12 C11 H8 H7"
        ]
    }}
    it 'POSTリクエストのレスポンスステータスは201となること' do
      post '/api/ver1/poker_api', params2
      expect(response.status).to eq 201
    end
    context '異常値が含まれる場合' do
      it 'resultsとerrorsの結果が正しいこと' do
        post '/api/ver1/poker_api', params1
        json = JSON.parse(response.body)
        expect(json['errors'][0]).to have_key('message')
        expect(json['results'][0]['best']).to eq 'true'
        expect(json['results'][1]['best']).to eq 'false'
      end
    end
    context '正常値のみの場合' do
      it 'resultsが正しいこと' do
        post '/api/ver1/poker_api', params2
        json = JSON.parse(response.body)
        expect(json['results'][1]["best"]).to eq 'true'
        expect(json['results'][2]["best"]).to eq 'false'
      end
    end
  end
end
