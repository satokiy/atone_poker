require 'card'
class Pokerhands < Card

  def check_role
    roles = [
        {role: 'ストレートフラッシュ', score: 8000, key: 1105},
        {role: 'ストレート', score: 4000, key: 1005},
        {role: 'フラッシュ', score: 5000, key: 105},
        {role: '4カード', score: 7000, key: 12},
        {role: 'フルハウス', score: 6000, key: 2},
        {role: '3カード', score: 3000, key: 13},
        {role: '2ペア', score: 2000, key: 3},
        {role: 'ハイカード', score: 0, key: 5},
        {role: '1ペア', score: 1000, key: 14},
    ]

    n = @cardnumbers.uniq.count
    if n == 5 && @cardnumbers.max - @cardnumbers.min == 4
      n += 1000
    end
    if @cardsuits.uniq.count == 1 #スートがすべて同じ
      n += 100
    end
    if @cardnumbers.select {|m| @cardnumbers.count(m) > 1}.uniq.count == 1
      n += 10
    end
    @role = roles.find {|item| item[:key] == n}
  end
end


