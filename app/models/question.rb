class Question < ActiveRecord::Base
  belongs_to :event
  validates_presence_of :body
  has_many :question_comments, dependent: :destroy
  has_many :question_answers, dependent: :destroy

  def format_comments
    binding.pry
    question_comments.each do |comment|
      puts "#{comment.body}"
    end
  end

end