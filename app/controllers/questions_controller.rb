class QuestionsController < ApplicationController

 def new
    @event = Event.find(params[:event_id])
    @review = @event.questions.build
  end

  def create
    @event = Event.find(params[:event_id])
    @question = @event.questions.build(question_params)
    if @question.save
       flash[:question_added] = "Question Added"
       redirect_to event_path(@event)
    else
       flash[:question_can_not_be_blank] = "Add a valid question to submit"
       redirect_to event_path(@event)
    end
  end

  def question_params
    params.require(:question).permit(:body)
  end

end