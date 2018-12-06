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
    it 'レスポンスはresultsとerrorsのキーを持っていること' do
      post '/api/ver1/poker_api', params1
      json = JSON.parse(response.body)
      expect(json).to have_key('results')
      expect(json).to have_key('errors')
    end
    it 'resultsが正しいこと' do
      post '/api/ver1/poker_api', params2
      json = JSON.parse(response.body)
      expect(json["results"][1]["best"]).to eq "true"

    end
  end
end
