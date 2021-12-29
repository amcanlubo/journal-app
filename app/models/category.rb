class Category < ApplicationRecord
    validates :name, presence: true, uniqueness: true, length: { minimum: 3 }

    has_many :tasks, dependent: :destroy
end
