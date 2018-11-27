class Card

  def initialize(cards:)
    @errors = [
        "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。",
        "カードが入力されていません",
        "◯◯番目のカード（<入力されたカード>）が不正です",
        "カードが重複しています",
        "カードの枚数は5枚です"
    ]
    @card = cards
    @card = @card.gsub(/\p{blank}+/, ' ') #全角スペースを半角スペースに
    @card = @card.gsub(/\s+/, ' ') #半角スペースが2個以上あった場合に1つにする
    @card = @card.upcase #小文字をすべて大文字に
    @cardlist = @card.split(/\s/) #入力値を5つのカード配列に分割
    @cardsuits =  @cardlist.map {|card| card.split(//, 2)}.map(&:first) #5つのカード配列のうちスートだけを抜き出した配列
    @cardnumbers = @cardlist.map {|card| card.split(//, 2)}.map(&:last).map(&:to_i) #5つのカード配列のうち数字だけを抜き出した配列
  end

  def blank?
    if @card.blank?
      return @errors[1]
    end
  end

  def check_string
    if @card.gsub(/\s+/, '') =~ /[^[a-zA-Z0-9]+$]/
      return @errors[0]
    end
  end

  def format_card
    return @card
  end

  def split_card
    return @cardlist
  end

  def get_suit
    return @cardsuits
  end

  def get_number
    return @cardnumbers
  end

  def check_length
    if @cardlist.length != 5
      return @errors[4]
    end
  end

  def check_duplication
  if @cardlist.count - @cardlist.uniq.count > 0
    return @errors[3]
  end


  end
  end

