class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  enum status: {active: 0, canceled: 1}

  def self.make_sub(customer_id, tea_id, frequency)
    Subscription.create(find_params(customer_id, tea_id, frequency))
  end

  private
  def self.find_params(customer_id, tea_id, frequency)
    tea_object = Tea.find(tea_id)
    price = tea_object.price
    title = "#{tea_object.title} Subscription"

    { title: title, price: price , status: 0, frequency: frequency, customer_id: customer_id, tea_id: tea_id}
  end
end
