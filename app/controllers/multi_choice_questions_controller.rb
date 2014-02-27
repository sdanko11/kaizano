class MultiChoiceQuestionsController < ApplicationController

  def index
    @multi_choice_question = MultiChoiceQuestion.find(params[:event_id])
    @multi_choice_answers = @multi_choice_question.multi_choice_answers.load
  end

  def new
    if session[:update_route].nil?
      session[:last_page_viewed] = request.env['HTTP_REFERER']
    end
    @event = Event.find(params[:event_id])
    @multi_choice_question = @event.multi_choice_questions.build
  end

  def create
    @event = Event.find(params[:event_id])
    @multi_choice_question = @event.multi_choice_questions.build(multi_choice_question_params)
    if @multi_choice_question.save
      if params[:commit] == "Save & Add Another Question"
        session[:update_route] = "no"
        redirect_to new_event_multi_choice_question_path(@event)
      elsif session[:last_page_viewed].include?(@event.id.to_s)
        session[:update_route] = nil
        flash[:question_saved] = "Saved"
        redirect_to session[:last_page_viewed]
      else
        session[:update_route] = nil
        flash[:question_saved] = "Saved"
        redirect_to user_path(current_user)
      end 
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:event_id])
    @multi_choice_question = MultiChoiceQuestion.find(params[:id])
    @multi_choice_answer = MultiChoiceAnswer.new
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

  def destroy
    @multi_choice_question = MultiChoiceQuestion.find(params[:id]).destroy
    flash[:deleted_question] = "Deleted Question"
    redirect_to edit_event_path(@multi_choice_question.event)
  end

  private

  def multi_choice_question_params
    params.require(:multi_choice_question).permit(:question_body, :answer_a, :answer_b, :answer_c, 
    :answer_d, :answer)
  end

end