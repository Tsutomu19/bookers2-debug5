class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following
  attachment :profile_image, destroy: false

  def followed_by?(user)
       passive_relationships.find_by(following_id: user.id).present?
  end

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction,
     length: { maximum: 50, message: 'is too long (maximum is 50 characters)' }

     def self.search(search_way,search)
          if search_way == 'forward_match'
               User.where('name LIKE ?',"#{search}%")
          elsif search_way == 'backward_match'
               User.where('name LIKE ?',"%#{search}")
          elsif search_way == 'backward_match'
               User.where('name LIKE ?',"%#{search}%")
          elsif search_way == 'perfect_match'
               User.where(name: "#{search}")
          else
               User.all
          end
     end
end
