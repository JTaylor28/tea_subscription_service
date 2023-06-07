class Api::V1::SubscriptionsController < ApplicationController

  def create
    subscription = Subscription.make_sub(params[:customer_id], params[:tea_id], params[:frequency])
    render json: SubscriptionSerializer.new(subscription)
  end
end