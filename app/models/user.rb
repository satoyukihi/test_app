class User < ApplicationRecord
  # ユーザーセーブ前にemailをすべて小文字にする
  before_save { self.email = email.downcase }

  # emailフォーマット定義
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  # 名前空＋長さ15
  validates :name, presence: true, length: { maximum: 15 },
                   uniqueness: true

  # email空＋長さ255＋フォーマット+ユニーク（大文字）小文字区別なし

  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  # 空でない＋最小6文字
  validates :password, presence: true, length: { minimum: 6 }

  has_secure_password
end
