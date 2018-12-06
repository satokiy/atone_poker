require 'rails_helper'

describe Pokerhands do
  describe '#check_role' do
    it 'check_HighCard' do
      card = Pokerhands.new(cards: 'D4 S5 H7 H3 C10')
      expect(card.check_role[:role]).to eq 'ハイカード'
    end
    it 'check_1Pair' do
      card = Pokerhands.new(cards: 'D4 S5 H7 H10 C10')
      expect(card.check_role[:role]).to eq '1ペア'
    end
    it 'check_2Pair' do
      card = Pokerhands.new(cards: 'D4 S7 H7 H10 C10')
      expect(card.check_role[:role]).to eq '2ペア'
    end
    it 'check_3card' do
      card = Pokerhands.new(cards: 'D4 S10 H7 H10 C10')
      expect(card.check_role[:role]).to eq '3カード'
    end
    it 'check_straight' do
      card = Pokerhands.new(cards: 'D4 S5 H7 H3 C6')
      expect(card.check_role[:role]).to eq 'ストレート'
    end
    it 'check_flash' do
      card = Pokerhands.new(cards: 'C4 C5 C7 C3 C12')
      expect(card.check_role[:role]).to eq 'フラッシュ'
    end
    it 'check_fullhouse' do
      card = Pokerhands.new(cards: 'D7 S7 H7 H6 C6')
      expect(card.check_role[:role]).to eq 'フルハウス'
    end
    it 'check_4card' do
      card = Pokerhands.new(cards: 'D6 S5 S6 H6 C6')
      expect(card.check_role[:role]).to eq '4カード'
    end
    it 'check_straight_flash' do
      card = Pokerhands.new(cards: 'C4 C5 C7 C3 C6')
      expect(card.check_role[:role]).to eq 'ストレートフラッシュ'
    end
  end
end

