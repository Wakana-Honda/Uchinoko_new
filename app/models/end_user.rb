class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :records, dependent: :destroy
  has_many :pets, dependent: :destroy
  has_many :foods, dependent: :destroy
  has_many :genres, dependent: :destroy
  has_many :types, dependent: :destroy
 
end
