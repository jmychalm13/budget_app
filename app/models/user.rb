class User < ApplicationRecord
  has_secure_password

  has_many :incomes
  has_many :expenses
  has_many :budgets

  validates :email, presence: true, uniqueness: true
end
