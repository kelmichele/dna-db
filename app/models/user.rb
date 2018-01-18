class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable ,:validatable
  # validates_presence_of :email, :password, unless: :guest?

  # validates_uniqueness_of :email, unless: :guest?
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates_format_of :email, with: VALID_EMAIL_REGEX, unless: :guest?

  has_many :personal_messages, dependent: :destroy
  has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'received_id'

  has_many :notes
  has_many :chatrooms, foreign_key: :sender_id

  def name
  	email.split('@')[0]
	end

  def online?
    !Redis.new.get("user_#{self.id}_online").nil?
  end

  # def self.new_guest
  #   new { |u| u.guest = true }
  # end

  def is_guest?
    User.where(guest: true)
  end
end
