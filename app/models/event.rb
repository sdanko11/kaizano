class Event < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :description
  belongs_to :user
  has_many :reviews


  def self.search(search)
    if search != nil
      # search = search.join
      Event.where("event_password like ?", "#{search}")
      # Event.find_by(event_password: search)
    end
  end

end