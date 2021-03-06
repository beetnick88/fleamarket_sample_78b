class Product < ApplicationRecord
  has_many :images, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  validates :images, presence: true
  belongs_to :category
  belongs_to :brand, optional: true
  belongs_to :delivery_charge
  belongs_to :condition
  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :saler, class_name: "User", optional: true
  belongs_to :buyer, class_name: "User", optional: true
  has_many :comments
  validates :name, presence: true, length:{maximum:40}
  validates :description, presence: true, length:{maximum:1000}
  validates :category, presence: true
  validates :condition, presence: true
  validates :delivery_charge, presence: true
  validates :prefecture, presence: true
  validates :day, presence: true
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}
  # has_many credit_cards

  # productのお気に入り判定 → vies側で呼び出し
  def bookmark_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end

  def self.search(search)
    return Product.all unless search
    Product.where('name LIKE(?)', "%#{search}%")
  end


  enum prefecture: {
    " ":0,
    北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
    茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
    新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
    岐阜県:21,静岡県:22,愛知県:23,三重県:24,
    滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
    鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
    徳島県:36,香川県:37,愛媛県:38,高知県:39,
    福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,沖縄県:47
  }
end
