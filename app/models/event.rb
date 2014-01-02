class Event < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :event_password
  belongs_to :user
  has_many :reviews, :dependent => :destroy
  validates_length_of :event_password, :maximum => 8

  def self.search(search)
    if search != nil
      # search = search.join
      Event.where("event_password like ?", "#{search}")
      # Event.find_by(event_password: search)
    end
  end

end