class MultiChoiceQuestionsController < ApplicationController

  def index
    @multi_choice_questions = MultiChoiceQuestion.all
  end

  def new
    @event = Event.find(params[:event_id])
    @multi_choice_question = @event.multi_choice_questions.build
  end

  def create
    @event = Event.find(params[:event_id])
    @multi_choice_question = @event.multi_choice_questions.build(multi_choice_question_params)
    if @multi_choice_question.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def show
    @multi_choice_answer = MultiChoiceAnswer.new
    if params[:id] == "no_id"
      @event = Event.find(params[:event_id])
      @multi_choice_question = @event.multi_choice_questions.first
    else
      @event = Event.find(params[:event_id])
      all_multi_choice_questions = @event.multi_choice_questions.all
      last_question_answered = MultiChoiceQuestion.find(params[:id])
      index = all_multi_choice_questions.index(last_question_answered)
      index += 1
      @multi_choice_question = all_multi_choice_questions[index]
      if @multi_choice_question.nil?
        redirect_to root_path
      end
    end
  end

  def multi_choice_question_params
    params.require(:multi_choice_question).permit(:question_body, :answer_a, :answer_b, :answer_c, 
    :answer_d, :answer)
  end

end