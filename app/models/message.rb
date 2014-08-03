class Message < ActiveRecord::Base
  attr_accessible :subject
  has_many :conversations
  has_many :message_statuses
  has_many :users, :through => :message_statuses, :source => :user

  validates :subject, :presence => true

#  searchable do
#    text :subject
#    text :conversations_content
#  end
#
#  def conversations_content
#    conversations.collect(&:content).join(" ")
#  end

#  def previous_message
#    self.class.first(:conditions => ["updated_at < ?", updated_at], :order => "updated_at ASC")
#  end
#
#  def next_message
#    self.class.first(:conditions => ["updated_at > ?", updated_at], :order => "updated_at ASC")
#  end

  def find_other_recipients(user)
    self.users.find(:all)
  end

  def find_message_statuses
    self.message_statuses
  end

  def message_owner
    self.message_statuses.user
  end

end
