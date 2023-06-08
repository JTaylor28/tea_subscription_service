class Api::V1::SubscriptionsController < ApplicationController

  def create
    subscription = Subscription.make_sub(subscription_params[:customer_id], subscription_params[:tea_id], subscription_params[:frequency])
    render json: SubscriptionSerializer.new(subscription)
  end

  def update
    subscription = Subscription.find(params[:id])
    subscription.update(status: params[:status])
    render json: SubscriptionSerializer.new(subscription)
  end

  private

  def subscription_params
    params.require(:subscription).permit(:customer_id, :tea_id, :frequency)
  end
end