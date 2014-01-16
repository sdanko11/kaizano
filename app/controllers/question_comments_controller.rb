class QuestionCommentsController < ApplicationController
 
  def new
    @question = Question.find(params[:question_id])
    @question_comment = @question.question_commentss.build
  end

  def create
    @question = Question.find(params[:question_id])
    @question_comment = @question.question_comments.build(question_comment_params)
    respond_to do |format|
      if @question_comment.save
        format.html { redirect_to :back }
        format.json { render json: @question_votes }
      else
        format.html { redirect_to :back }
        format.json { render json: @question_votes.errors, status: :unprocessable_entity }
      end
    end
  end

  def question_comment_params
    params.require(:question_comment).permit(:body)
  end

end