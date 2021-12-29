class Task < ApplicationRecord
  validates :name, presence:true, uniqueness:true, length: { minimum: 3 }
  validates :body, presence:true, length: { minimum: 10, maximum:50 }
  validates :task_date, presence:true

  belongs_to :category
end
