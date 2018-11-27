class HomeController < ApplicationController
  def top
  end

  def validate
    errors = [
        "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。",
        "カードが入力されていません",
        "◯◯番目のカード（<入力されたカード>）が不正です",
        "カードが重複しています",
        "カードの枚数は5枚です"

    ]

    if cards.blank?
      @error = errors[1]

    end
    if cardList.length != 5
      @error = "要素の数がおかしいですよ"
    end

    if cards.gsub(/\s+/, '') =~ /[^[a-zA-Z0-9]+$]/
      @error = errors[0]
    end

    if cardList.count - cardList.uniq.count > 0
      @error = errors[3]
    end


    cardList.each.with_index(1) {|card, index|
      if card !~ /[SDCH]([1-9]|1[0-3])\z/
        puts "#{index}番目のカードの値が間違っています(#{card})"
      end }

    end

  def check



    hands = [
        {role: "ストレートフラッシュ", score: 8000},
        {role: "フラッシュ", score: 5000},
        {role: "4カード", score: 7000},
        {role: "フルハウス", score: 6000},
        {role: "3カード", score: 3000},
        {role: "2ペア", score: 2000},
        {role: "ストレート", score: 4000},
        {role: "ハイカード", score: 0},
        {role: "1ペア", score: 1000},
    ]

    cards = params[:cards]
    session[:cards] = params[:cards]
    cards.gsub!(/\p{blank}+/, ' ') #全角スペースを半角スペースに
    cards.gsub!(/\s+/, ' ') #半角スペースが2個以上あった場合に1つにする

    cardList = cards.split(/\s/) #入力値を5つのカード配列に分割
    cardList.each { |card| card.upcase!} #小文字をすべて大文字に
    cardSuits = cardList.map {|card| card.split(//, 2)}.map(&:first) #5つのカード配列のうちスートだけを抜き出した配列
    cardNumbers = cardList.map {|card| card.split(//, 2)}.map(&:last).map(&:to_i) #5つのカード配列のうち数字だけを抜き出した配列

    #このタイミングでバリデーション
    validate
    render("home/top") and return if @error.present?

    n = 0
    m = 1

    if cardSuits.uniq.count == 1 #スートがすべて同じ

      if cardNumbers.uniq.count == 5 && cardNumbers.max - cardNumbers.min == 4 #数字がばらばら∧ max-minが4
        n += 0 #ストレートフラッシュ
      else
        n += 1 #フラッシュ
      end

    else
      n += 2
      m += 1
      if cardNumbers.uniq.count == m #数値が2種類
        if cardNumbers.select {|m| cardNumbers.count(m) > 1}.uniq.count == 1
          n += 0 #4カード
        else
          n += 1 #フルハウス
        end

      else
        n += 2
        m += 1
        if cardNumbers.uniq.count == m #数値が3種類
          if cardNumbers.select {|m| cardNumbers.count(m) > 1}.uniq.count == 1
            n += 0 #3カード
          else
            n += 1 #2ペア
          end

        else
          n += 2
          m += 2
          if cardNumbers.uniq.count == m #数値が5種類
            if cardNumbers.max - cardNumbers.min == 4 #trueならストレート
              n += 0 #ストレート
            else
              n += 1 #ハイカード
            end
          else
            n += 2 #1ペア
          end
        end
      end
    end

    hand = hands[n]
    session[:hand] = hand[:role]

    redirect_to ("/")

  end


  #ストレートの書き方
  # １．同じ値が存在しない∧最大値と最小値の差が4
  # ２．値をソートして下記の繰り返し
  #   n = o
  #   m = array[n]
  # if array[n] = array[n+1] - 1
  #     n += 1
  # end
end

