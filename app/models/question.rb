class Question < ActiveRecord::Base
  belongs_to :event, dependent: :destroy
  validates_presence_of :body
  has_many :question_comments, dependent: :destroy
  has_one :question_answer, dependent: :destroy

  def format_comments
    question_comments.each do |comment|
      puts "#{comment.body}"
    end
  end

end