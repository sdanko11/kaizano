class QuestionVotesController < ApplicationController
 def new
    @question = Question.find(params[:question_id])
    @question_vote = @question.question_votes.build
 end

  def create
    @question = Question.find(params[:question_id])
    @question_votes = @question.question_votes.build
    respond_to do |format|
      if @question_votes.save
        format.html { redirect_to :back }
        format.json { render json: @question_votes }
      else
        format.html { redirect_to :back }
        format.json { render json: @question_votes.errors, status: :unprocessable_entity }
      end
    end
  end
end