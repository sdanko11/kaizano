class MultiChoiceAnswersController < ApplicationController

  def create
    @multi_choice_question = MultiChoiceQuestion.find(params[:multi_choice_question_id])
    @event = Event.find(@multi_choice_question.event_id)
    if params[:multi_choice_answer].nil?
      flash[:add_a_valid_answer] = "Must Choose a Answer to Submit"
      redirect_to :back
    else
      @multi_choice_question.multi_choice_answers.build(multi_choice_answer_params).save
      if @multi_choice_question.last_question?
        session[:answered_multi_choice] << @event.id
        flash[:answered_questions] = "Answers Submitted"
        redirect_to event_path(@event)
      else
        redirect_to event_multi_choice_question_path(@event, @multi_choice_question.get_next_question)
      end
    end
  end
  
  private

  def multi_choice_answer_params
    params.require(:multi_choice_answer).permit(:answer_submission)
  end

end