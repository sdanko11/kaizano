class QuestionVote < ActiveRecord::Base
  belongs_to :question, :counter_cache => true
end
