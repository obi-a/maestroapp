class User < ActiveRecord::Base
  has_many :ragios_monitors
  has_many :email_notifiers
  before_create :set_role
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  def set_role
    self.add_role :regular
  end
end
