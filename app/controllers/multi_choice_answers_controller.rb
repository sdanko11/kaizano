class MultiChoiceAnswersController < ApplicationController
  
  def create
    @multi_choice_question = MultiChoiceQuestion.find(params[:multi_choice_question_id])
    @event = Event.find(@multi_choice_question.event_id)
    if params[:multi_choice_answer]
      @multi_choice_answer = @multi_choice_question.multi_choice_answers.build(multi_choice_answer_params)
      if @multi_choice_answer.save
        redirect_to event_multi_choice_question_path(@event, @multi_choice_question)
      else
        render :new
      end
    else
      redirect_to :back
    end
  end

  def multi_choice_answer_params
    params.require(:multi_choice_answer).permit(:answer_submission, :multi_choice_question_id)
  end

end