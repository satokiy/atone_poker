require 'rails_helper'

describe Card do
  describe 'validation' do
    context 'check_valid_string' do
      it '何も入力されなかった場合のエラー' do
        card = Card.new(cards: " ")
        expect(card.blank?).to match({:message => 'カードが入力されていません。'})
      end
      it '英数字以外の文字が含まれた場合のエラー' do
        card = Card.new(cards: "んbtrしｒごじゃｓ")
        expect(card.check_string).to match({:message => '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。'})

      end
    end
    context 'カードから必要要素を抽出する' do
      describe '空白をすべて半角スペースにする' do
        it 'format' do
          card = Card.new(cards: 'D4     S5 h7　　　H3 s10')
          expect(card.card).to eq 'D4 S5 H7 H3 S10'
        end
      end
      describe '入力された文字列をカード・数字・スートに分割' do
        let(:params) {{cards: 'D4 S5 H7 H3 C10'}}
        let(:card) {Card.new(params)}

        it 'カード群に分割する' do
          expect(card.cardlist).to eq ["D4", "S5", "H7", "H3", "C10"]
        end
        it 'カードのスートだけを抽出する' do
          expect(card.cardsuits).to eq ["D", "S", "H", "H", "C"]
        end
        it 'カードの数値だけを抽出する' do
          expect(card.cardnumbers).to eq [4, 5, 7, 3, 10]
        end
      end
    end
    context '分割されたカードに対してバリデーションをかける' do
      it 'カードが5枚未満のとき' do
        card = Card.new(cards: 'D4 S5 H7 H3')
        expect(card.check_length).to match({:message => 'カードの枚数は5枚です。5枚のカードはスペースで区切ってください。'})
      end
      it 'カードが6枚以上のとき' do
        card = Card.new(cards: 'D4 S5 H7 H3 C10 D12')
        expect(card.check_length).to match({:message => 'カードの枚数は5枚です。5枚のカードはスペースで区切ってください。'})
      end
      it 'カードに重複があるとき' do
        card = Card.new(cards: 'D4 S5 H7 H3 H3 ')
        expect(card.check_duplication).to match({:message => 'カードが重複しています。'})
      end
      it '5枚目のカードが不正のとき' do
        card = Card.new(cards: 'D4 S5 H7 H3 山田')
        expect(card.check_each_cards).to match([{:message => '5番目のカード(山田)が間違っています'}])
      end
      it '4枚目のカードが不正' do
        card = Card.new(cards: 'D4 S5 H7 やまだ H3')
        expect(card.check_each_cards).to match([{:message => '4番目のカード(やまだ)が間違っています'}])
      end
      it '3枚目のカードが不正のとき' do
        card = Card.new(cards: 'D4 S5 yamada H7 H3')
        expect(card.check_each_cards).to match([{:message => '3番目のカード(YAMADA)が間違っています'}])
      end
      it '2枚めのカードが不正のとき' do
        card = Card.new(cards: 'D4 山田 S5 H7 H3')
        expect(card.check_each_cards).to match([{:message => '2番目のカード(山田)が間違っています'}])
      end
      it '1枚目のカードが不正のとき' do
        card = Card.new(cards: '山田 D4 S5 H7 H3')
        expect(card.check_each_cards).to match([{:message => '1番目のカード(山田)が間違っています'}])
      end
    end
  end
end
