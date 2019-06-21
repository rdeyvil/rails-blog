class Article < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true, length: {minimum:3, maximum:50}
  validates :description, presence: true, length: {minimum:10}
  validates :user_id, presence: true

  def check_user_authorization(current_user)
    user.id == current_user.id && !current_user.admin?
  end
end
