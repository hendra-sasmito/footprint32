class Conversation < ActiveRecord::Base
  attr_accessible :content, :message_id, :sender_id

  belongs_to :sender, :class_name => "User"
  belongs_to :message

  validates :content, :presence => true
  validates :message_id, :presence => true
  validates :sender_id, :presence => true
end
