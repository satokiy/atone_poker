class Card
  attr_reader :cardlist
  attr_accessor :card
  attr_accessor :cardsuits
  attr_accessor :cardnumbers

  def initialize(cards:)
    @errors = [
        {message: '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。'},
        {message: 'カードが入力されていません。'},
        {message: ''},
        {message: 'カードが重複しています。'},
        {message: 'カードの枚数は5枚です。5枚のカードはスペースで区切ってください。'},
    ]
    @card = cards
    @card = @card.gsub(/\p{blank}+/, ' ') #全角スペースを半角スペースに
    @card = @card.gsub(/\s+/, ' ') #半角スペースが2個以上あった場合に1つにする
    @card = @card.upcase #小文字をすべて大文字に
    @cardlist = @card.split(/\s/) #入力値を5つのカード配列に分割
    @cardsuits = @cardlist.map {|card| card.split(//, 2)}.map(&:first) #5つのカード配列のうちスートだけを抜き出した配列
    @cardnumbers = @cardlist.map {|card| card.split(//, 2)}.map(&:last).map(&:to_i) #5つのカード配列のうち数字だけを抜き出した配列
  end

  #attr_reader :cardlist と同じ意味
  # def cardlist
  #   @cardlist
  # end


  def blank? #空白チェック
    @errors[1] if @card.blank?
  p "AA"
    p "AA"
  end

  #英数字の文字列であることをチェックして、ハッシュで返す
  def check_string
    @errors[0] if @card.gsub(/\s+/, '') =~ /[^[a-zA-Z0-9]+$]/
  end

  #カード枚数が5枚かチェックして、ハッシュで返す
  def check_length
    @errors[4] if @cardlist.length != 5
  end

  #重複がないかチェックして、ハッシュで返す
  def check_duplication
    @errors[3] if @cardlist.count - @cardlist.uniq.count > 0
  end

  #各カードが正しい値かチェックして、ハッシュの配列で返す
  def check_each_cards
    errors = []
    index = 1
    @cardlist.each do |card|
      error = {}
      if card !~ /[SDCH]([1-9]|1[0-3])\z/
        error[:message] = "#{index}番目のカード(#{card})が間違っています"
        errors << error
      end
      index += 1
    end

    if errors.empty?
      nil
    else
      errors
    end

  end

  #文字列のバリデーションをまとめ、ハッシュの配列で返す
  def validation
    array = []
    if self.check_string
      array << self.check_string
    end
    if self.check_length
      array << self.check_length
    end
    if self.check_duplication
      array << self.check_duplication
    end
    if self.check_each_cards
      a = self.check_each_cards
      a.each do |b|
        array << b
      end
    end
    if array.blank?
      nil
    else
      array
    end
  end


end

