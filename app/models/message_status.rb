class MessageStatus < ActiveRecord::Base
  attr_accessible :message_id, :status, :user_id, :start_at

  belongs_to :user
  belongs_to :message
  has_many :conversations, :through => :message, :foreign_key => "message_id"

  UNREAD  = 0
  READ    = 1
  DELETED = 2
  SENT    = 3
  VALID_STATUS = [UNREAD, READ, DELETED, SENT]

  validates_inclusion_of    :status,
                            :in => VALID_STATUS,
                            :allow_nil => false,
                            :message => "must be a valid message status"
  validates :message_id, :presence => true
  validates :user_id, :presence => true

  scope :undeleted, where("message_statuses.status != ?", DELETED)

  searchable do
#    text :subject
    integer :user_id
    text :conversations_content
    text :message do
      message.subject
#      text :conversations_content
#      message.conversations do
#        text :conversations_content
#      end
    end
  end

  def conversations_content
    conversations.collect(&:content).join(" ")
  end

  def self.associate_user(message, sender, recipients)
    transaction do
      create(:message_id => message.id, :user_id => sender.id, :status => SENT)
      recipients.each do |recipient|
#        user = User.find(recipient)
        create(:message_id => message.id, :user_id => recipient, :status => UNREAD)
      end
    end
  end
end
