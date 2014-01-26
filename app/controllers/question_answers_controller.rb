class QuestionAnswersController < ApplicationController

  def new
    @question = Question.find(params[:question_id])
    @question_answer = @question.question_answers.build
  end

  def create
    @question = Question.find(params[:question_id])
    @event = Event.find(@question.event_id)
    @question_answer = @question.question_answers.build(question_answer_params)
    if @question_answer.save
      flash[:answer_saved] = "Answer Saved Succesfully"
      redirect_to event_reviews_path(@event)
    else
      render :new
    end
  end

  private

  def question_answer_params
    params.require(:question_answer).permit(:answer_body)
  end


end