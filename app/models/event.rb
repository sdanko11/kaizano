class Event < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :description
  belongs_to :user
  has_many :reviews


  def self.search(search)
    search = search.join
    Event.where("event_password like ?", "#{search}")
  end

end