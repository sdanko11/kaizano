class Question < ActiveRecord::Base

  validates_presence_of :body
  
  has_many :question_comments, 
    dependent: :destroy
  
  has_one :question_answer, 
    dependent: :destroy

  belongs_to :event

  def format_comments
    question_comments.each do |comment|
      "#{comment.body}"
    end
  end

end