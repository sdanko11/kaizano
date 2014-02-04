class MultiChoiceQuestionsController < ApplicationController

  def new
    @event = Event.find(params[:event_id])
    @multi_choice_question = @event.multi_choice_questions.build
    binding.pry
  end

  def create
    @event = Event.find(params[:event_id])
    @multi_choice_question= @event.multi_choice_questions.build(multi_choice_question_params)
    if @multi_choice_question.save
      redirect_to root_path
    else
      render :new
    end
  end


  def multi_choice_question_params
    params.require(:multi_choice_question).permit(:question_body, :answer_a, :answer_b, :answer_c, 
    :answer_d)
  end

end