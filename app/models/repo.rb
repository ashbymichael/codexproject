class Repo < ActiveRecord::Base
  belongs_to :plan

  validates :plan_id, presence: true
  validates :url, presence: true
  validates :stars, presence: true
  validates :forks, presence: true
  validates :size, presence: true

end
