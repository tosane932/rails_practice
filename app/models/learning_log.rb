class LearningLog < ApplicationRecord
  # 同じ日付に2重登録するのを防ぐ現場主義のバリデーション
  validates :learned_on, presence: true, uniqueness: true
  validates :duration_mins, presence: true, numericality: { greater_than: 0 }

  # 1. 累計学習時間を「〇〇時間」として自動演算するクラスメソッド
  def self.total_hours
    total_mins = sum(:duration_mins)
    (total_mins / 60.0).round(1) # 分を時間に変換し、小数点第1位で四捨五入
  end

  # 2. 実際の総学習日数を自動カウントするクラスメソッド
  def self.total_days
    count # レコード数がそのまま日数になるシンプルな設計
  end

  # 3. 現在の「Lv」を総時間から自動算出する遊び心ロジック（例: 5時間ごとに1Lvアップ）
  def self.current_level
    (total_hours / 5.0).to_i + 1
  end
end