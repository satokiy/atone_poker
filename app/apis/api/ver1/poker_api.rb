module API
  module Ver1
    class PokerApi < Grape::API
      require 'pokerhands'
      require 'card'

      version 'ver1'
      prefix 'api'
      format :json
      resource :poker_api do
        desc 'ポーカーの役を返す'
        params do
          requires :cards
        end
        # /api/ver1/poker_api
        post do

          @cards = params[:cards]
          hash = {}
          hash[:errors] = []
          hash[:results] = []
          score_results = []

          @cards.each do |card|
            hands = Pokerhands.new(cards: card)
#空白の場合errors配列にエラーを入れて返す
            if hands.blank?
              hands.blank?[:cards] = card
              hash[:errors] << hands.blank?
#異常値の場合errors配列にエラーを入れて返す
            elsif hands.validation
              array = hands.validation
              array.each do |item|
                hash[:errors] << item
              end
              hash[:errors] << {cards: card}
#正常値の場合results配列に役を入れて返す
            else
              aaa = hands.check_role
              score_results << aaa[:score]
              aaa[:cards] = card
              hash[:results] << aaa
            end
          end
#正常値に対してscoreの強弱判定bestをtrue/falseでつける
          hash[:results].each do |a|
            if a[:score] == score_results.max
              a[:best] = 'true'
            else
              a[:best] = 'false'
            end
          end

#結果にscoreは不要なので消す
          hash[:results].each do |a|
            a.delete(:score)
          end
#結果を返す
          if hash[:errors].blank?
            hash.delete(:errors)
          end
          return hash

        end
      end
    end
  end
end


