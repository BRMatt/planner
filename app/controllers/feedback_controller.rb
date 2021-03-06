class FeedbackController < ApplicationController

  def show
    redirect_to action: 'not_found' unless Feedback.find_by_token(params[:id])

    @feedback = Feedback.new(token: params[:id])
  end

  def submit
    redirect_to action: 'not_found' unless Feedback.find_by_token(params[:id])

  	if Feedback.submit_feedback(feedback_params)
      redirect_to success_feedback_path
    else
      @feedback = Feedback.new(feedback_params)
      @feedback.valid?

      render 'show'
    end
  end

  def not_found; end

  def success; end

  private

  def feedback_params
  	params.require(:feedback).permit(:coach_id, :tutorial_id, :request, :rating, :suggestions, :token)
  end
end