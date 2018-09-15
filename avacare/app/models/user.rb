class User < ApplicationRecord
  has_many :conditions, dependent: :destroy
end
