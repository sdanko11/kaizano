class QuestionVotesController < ApplicationController
 def new
    @question = Question.find(params[:question_id])
    @question_vote = @question.question_votes.build
  end

  def create
    @question = Question.find(params[:question_id])
    @question_votes = @question.question_votes.build
    if @question.save
      redirect_to :back
    end
  end

end