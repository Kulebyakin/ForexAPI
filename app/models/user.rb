# frozen_string_literal: true

class User < ActiveRecord::Base

  has_many :accounts
  has_many :currencies, through: :account

  extend Devise::Models
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
end
