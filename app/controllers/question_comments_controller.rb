class QuestionCommentsController < ApplicationController
 
  def new
    @question = Question.find(params[:question_id])
    @question_comment = @question.question_commentss.build
  end

  def create
    @question = Question.find(params[:question_id])
    @question_comment = @question.question_comments.build(question_comment_params)
    if @question_comment.save
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def question_comment_params
    params.require(:question_comment).permit(:body)
  end

end