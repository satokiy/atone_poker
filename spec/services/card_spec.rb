require 'rails_helper'

describe Card do
  let(:card) { Card.new(params) }
  let(:params) { { cards: 'D4 S5 H7 F3 C10'}}

  describe '#valid' do
    it "valid" do
    expect(card.blank?).to eq nil
    end
  end
  describe 'check_string' do
    it 'check_string' do
    expect(card.check_string).to eq nil
    end
  end
  describe '#format' do
    it "format" do
    expect(card.format_card).to eq 'D4 S5 H7 F3 C10'
    end
  end
  describe 'split' do
    it 'split' do
    expect(card.split_card).to eq ["D4", "S5", "H7", "F3", "C10"]
    end
  end
  describe 'check_length' do
    it 'check_length' do
    expect(card.check_length).to eq nil
    end
  end
  describe 'check_duplication' do
    it 'check_duplication' do
    expect(card.check_duplication).to eq nil
    end
  end

end
