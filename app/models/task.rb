class Task < ApplicationRecord
  validates :name, presence:true
  validates :body, presence:true, length: { minimum: 10 }
  validates :task_date, presence:true

  belongs_to :category
end
