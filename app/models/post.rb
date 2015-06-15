class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_one :game, through: :event
end
