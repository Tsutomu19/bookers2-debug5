class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites
	has_many :post_comments

	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	def post_commented_by?(user)
        post_comments.where(user_id: user.id).exists?
	end

	def self.search(search_way,search)
		pp search_way
		pp search
		if search_way == 'forward_match'
			Book.where('title LIKE ?',"#{search}%")
		elsif search_way == 'backward_match'
			Book.where('title LIKE ?',"%#{search}")
		elsif search_way == 'partial_match'
			Book.where('title LIKE ?',"%#{search}%")
		elsif search_way == 'perfect_match'
			Book.where(title: "#{search}")
		  else
			Book.all
		  end
	  end
end



