class QuestionAnswersController < ApplicationController
  
  before_filter :does_user_own_event, :only => [:new, :create, :edit, :update]

  def new
    @question = Question.find(params[:question_id])
    @question_answer = @question.build_question_answer
  end

  def create
    @question = Question.find(params[:question_id])
    @event = Event.find(@question.event_id)
    @question_answer = @question.build_question_answer(question_answer_params)
    if @question_answer.save
      flash[:answer_saved] = "Answer Saved Succesfully"
      redirect_to event_reviews_path(@event)
    else
      render :new
    end
  end

  def edit
    @question_answer = QuestionAnswer.find(params[:id])
    @question = Question.find(params[:question_id])
  end

  def update
    @question = Question.find(params[:question_id])
    @question_answer = QuestionAnswer.find(params[:id])
    event = Event.find(@question.event_id)
    if @question_answer.update_attributes(question_answer_params)
      flash[:answer_saved] = "Answer Saved Succesfully"
      redirect_to event_reviews_path(event)
    else
      render :edit
    end
  end

  def does_user_own_event
    if user_signed_in?
      all_questions = []
      current_user.events.each do |event|
        event.questions.each do |question|
          all_questions << question.id.to_s
        end
      end
      redirect_to user_path(current_user) unless all_questions.include?(params[:question_id])
    else
      redirect_to root_path
    end
  end

  private

  def question_answer_params
    params.require(:question_answer).permit(:answer_body)
  end


end