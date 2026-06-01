class HomeController < ApplicationController
  def index

    def index
    # Pythonのリストと同じ！配列を作ります
    fortunes = ["大吉！今日のプログラミングはバグ無しじゃけぇ！", 
                "中吉！エラーが出てもC案で一撃ハント！", 
                "小吉！大賢者の見切りが冴え渡る一日！"]
    
    # 配列からランダムに1個選んで、画面に渡す変数（@omikuji）に入れます
    @omikuji = fortunes.sample
    end

  end

  def daikenja
  end

end
