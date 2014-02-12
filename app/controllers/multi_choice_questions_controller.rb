class MultiChoiceQuestionsController < ApplicationController

  def index
    @multi_choice_question = MultiChoiceQuestion.find(params[:event_id])
    @multi_choice_answers = @multi_choice_question.multi_choice_answers.load
  end

  def new
    @event = Event.find(params[:event_id])
    @multi_choice_question = @event.multi_choice_questions.build
  end

  def create
    @event = Event.find(params[:event_id])
    @multi_choice_question = @event.multi_choice_questions.build(multi_choice_question_params)
    if @multi_choice_question.save
      if params[:commit] == "Save Question"
        redirect_to new_event_multi_choice_question_path(@event)
      else
        redirect_to user_path(current_user)
      end 
    else
      render :new
    end
  end

  def edit 
    @event = Event.find(params[:event_id])
    @multi_choice_question = MultiChoiceQuestion.find(params[:id])
  end

  def update
    @event = Event.find(params[:event_id])
    @multi_choice_question = MultiChoiceQuestion.find(params[:id])
    if @multi_choice_question.update_attributes(multi_choice_question_params)
      flash[:answered_questions] = "Saved Changes"
      redirect_to edit_event_path(@event)
    end
  end

  def show
    @event = Event.find(params[:event_id])
    @multi_choice_answer = MultiChoiceAnswer.new
    if params[:id] == "no_id"
      @multi_choice_question = @event.multi_choice_questions.first
    else
      all_multi_choice_questions = @event.multi_choice_questions.load
      last_question_answered = MultiChoiceQuestion.find(params[:id])
      index = all_multi_choice_questions.index(last_question_answered)
      index += 1
      @multi_choice_question = all_multi_choice_questions[index]
      if @multi_choice_question.nil?
        session[:answered_multi_choice] << @event.id
        flash[:answered_questions] = "Answers Submitted"
        redirect_to event_path(@event)
      end
    end
  end

  private

  def multi_choice_question_params
    params.require(:multi_choice_question).permit(:question_body, :answer_a, :answer_b, :answer_c, 
    :answer_d, :answer)
  end

end