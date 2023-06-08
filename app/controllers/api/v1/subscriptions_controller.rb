class Api::V1::SubscriptionsController < ApplicationController
  
  def index
    customer = Customer.find(params[:customer_id])
    render json: SubscriptionSerializer.new(customer.subscriptions)
  end
  
  def create
    subscription = Subscription.make_sub(params[:customer_id], subscription_params[:tea_id], subscription_params[:frequency])
    render json: SubscriptionSerializer.new(subscription)
  end

  def update
    subscription = Subscription.find(params[:id])
    subscription.update(status: params[:status])
    render json: SubscriptionSerializer.new(subscription)
  end

  private

  def subscription_params
    params.require(:subscription).permit(:tea_id, :frequency)
  end
end