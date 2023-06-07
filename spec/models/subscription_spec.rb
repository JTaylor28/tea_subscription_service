require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should belong_to :tea }
  end
  
  describe "Methods" do
    before :each do
      @customer = Customer.create!(first_name: "Bob", last_name: "Gu", email: "bob@bobmail.com", address: "123 Bob St. Bob, CO 80302").id
      @tea = Tea.create!(title: "Green Tea", description: "Green Tea is green", temperature: 180, brew_time: 3, price: 10).id
    end

    describe "#make_sub" do
      it "creates a new subscription object when given valid paramaters" do
        frequency = "monthly"
        
        Subscription.make_sub(@customer, @tea, frequency)
        expect(Subscription.all.count).to eq(1)
        subscription = Subscription.last

        expect(subscription.title).to eq("Green Tea Subscription")
        expect(subscription.price).to eq(10)
        expect(subscription.status).to eq("active")
        expect(subscription.frequency).to eq(frequency)
        expect(subscription.customer_id).to eq(@customer)
        expect(subscription.tea_id).to eq(@tea)
      end
    end
  end
end