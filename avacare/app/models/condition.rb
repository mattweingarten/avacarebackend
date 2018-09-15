class Condition < ApplicationRecord
  has_many :symptoms, dependent: :destroy
  belongs_to :user
end
