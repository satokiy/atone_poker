class PokerApi < Grape::API
  prefix 'poker/'
  resource :hello do
    desc 'ポーカーの役を返す'

    # post /poker/hello
    get do

      #   入力したデータを受け取る
      #@cards=params[:cards]
      # データを加工して、homecontrollerが受け取れる形にする
      # コントローラに渡して、役をつける
      # 強さを判定する
      # 役とその強さを返す
      :hello
    end
  end
end
