class HomeController < ApplicationController
  # require 'card'
  require 'pokerhands'


  def top
    @errors = [{message: 'カードを入力してください'}]
  end


  def check
    @cards = params[:cards]
    hands = Pokerhands.new(cards: @cards)

    @errors = []
    if hands.blank?
      @errors << hands.blank?
    end
    render("home/top") and return if @errors[0].present?

    if hands.validation
      @errors = hands.validation
    end
    render("home/top") and return if @errors[0].present?


    @role = hands.check_role[:role]
    render ("home/top")
  end


end

