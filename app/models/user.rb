class User < ApplicationRecord
  has_many :payments

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  enum role: { admin: 0, otaku: 1}
  enum status: { inactive: 0, active: 1}


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :name , presence: true
end
