class WelcomeController < ApplicationController
  def index
    @message = "大賢者の見切り、ここに極まる。Rails攻略開始！"
    # データベースから、過去に保存されたすべての投稿を「新着順（逆順）」で取得して変数に突っ込む！
    @posts = Post.all.order(created_at: :desc)
  end

  def result
    @user_input = params[:input_text]
    
    # 🚨 ここで主が入力した文字をデータベースに永久保存！
    Post.create(content: @user_input)
  end

  def destroy
    # URLから渡ってきた :id を元に、消したいデータを1件特定する
    @post = Post.find(params[:id])
    @post.destroy # データベースから抹殺！
    
    # 削除が終わったら、一瞬でトップページ（1ページ目）に自動で戻る（リダイレクト）
    redirect_to root_path
  end

end