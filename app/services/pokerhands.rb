require 'card'
class Pokerhands < Card

  def check_role
    roles = [
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


    n = 0
    m = 1

    if @cardsuits.uniq.count == 1 #スートがすべて同じ

      if @cardnumbers.uniq.count == 5 && @cardnumbers.max - @cardnumbers.min == 4 #数字がばらばら∧ max-minが4
        n += 0 #ストレートフラッシュ
      else
        n += 1 #フラッシュ
      end

    else
      n += 2
      m += 1
      if @cardnumbers.uniq.count == m #数値が2種類
        if @cardnumbers.select {|m| @cardnumbers.count(m) > 1}.uniq.count == 1
          n += 0 #4カード
        else
          n += 1 #フルハウス
        end

      else
        n += 2
        m += 1
        if @cardnumbers.uniq.count == m #数値が3種類
          if @cardnumbers.select {|m| @cardnumbers.count(m) > 1}.uniq.count == 1
            n += 0 #3カード
          else
            n += 1 #2ペア
          end

        else
          n += 2
          m += 2
          if @cardnumbers.uniq.count == m #数値が5種類
            if @cardnumbers.max - @cardnumbers.min == 4 #trueならストレート
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
    roles[n]

  end

end


