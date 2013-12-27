class Event < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :description
  belongs_to :user
  has_many :reviews
  has_one :user
end