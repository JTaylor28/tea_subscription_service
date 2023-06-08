require "rails_helper"

RSpec.describe "Customers", type: :request do
  describe "GET /api/v1/customers/id/subscriptions" do
    before :each do
      @customer = Customer.create(first_name: "Bob", last_name: "Jones" , email: "bob@bobmail.com", address: "123 Bob St. Bob, CO 80302").id
      @customer_2 = Customer.create(first_name: "Sally", last_name: "Jones" , email: "sally@sally.com", address: "123 sal St. sal, CO 80302").id
      @tea = Tea.create(title: "Green Tea", description: "Green Tea is green", temperature: 180, brew_time: 3, price: 10).id
      @tea_2 = Tea.create(title: "Black Tea", description: "Black Tea is black", temperature: 200, brew_time: 5, price: 15).id
      @tea_3 = Tea.create(title: "Oolong Tea", description: "Oolong Tea is oolong", temperature: 190, brew_time: 4, price: 12).id
      @subscription = Subscription.create!(title: "Green Tea Subscription", price: 10 , status: 0, frequency: "monthly", customer_id: @customer, tea_id: @tea)
      @subscription_2 = Subscription.create!(title: "Black Tea Subscription", price: 15 , status: 1, frequency: "monthly", customer_id: @customer, tea_id: @tea_2)
      @subscription_3 = Subscription.create!(title: "Oolong Tea Subscription", price: 12 , status: 0, frequency: "monthly", customer_id: @customer, tea_id: @tea_3)
      @subscription_4 = Subscription.create!(title: "Green Tea Subscription", price: 10 , status: 0, frequency: "monthly", customer_id: @customer_2, tea_id: @tea)
    end
    
    it "returns all subscriptions for a customer regardless of sub status" do
      
      get "/api/v1/customers/#{@customer}/subscriptions"
      expect(response).to be_successful
      expect(response.status).to eq(200)


      cstmr_subs_json = JSON.parse(response.body, symbolize_names: true)
      expect(cstmr_subs_json[:data]).to be_a(Array)
      expect(cstmr_subs_json[:data].size).to eq(3)
      expect(cstmr_subs_json[:data][0][:attributes][:status]).to eq("active")
      expect(cstmr_subs_json[:data][1][:attributes][:status]).to eq("canceled")

      cstmr_sub_data = cstmr_subs_json[:data].each do |sub|
        expect(sub.keys).to eq([:id, :type, :attributes])
        expect(sub[:id]).to be_a(String)
        expect(sub[:type]).to eq("subscription")
        expect(sub[:attributes]).to be_a(Hash)
        expect(sub[:attributes].keys).to eq([:title, :price, :status, :frequency, :customer_id, :tea_id])
        expect(sub[:attributes][:title]).to be_a(String)
        expect(sub[:attributes][:price]).to be_a(Integer)
        expect(sub[:attributes][:status]).to be_a(String)
        expect(sub[:attributes][:frequency]).to be_a(String)
        expect(sub[:attributes][:customer_id]).to be_a(Integer)
        expect(sub[:attributes][:customer_id]).to eq(@customer)
      end
    end

    it " only returns subscriptions for specified customer" do
      get "/api/v1/customers/#{@customer_2}/subscriptions"
      expect(response).to be_successful
      expect(response.status).to eq(200)

      cstmr_subs_json = JSON.parse(response.body, symbolize_names: true)
      expect(cstmr_subs_json[:data]).to be_a(Array)
      expect(cstmr_subs_json[:data].size).to eq(1)

      cstmr_sub_data = cstmr_subs_json[:data].each do |sub|
        expect(sub[:attributes][:customer_id]).to eq(@customer_2)
        expect(sub[:attributes][:customer_id]).to_not eq(@customer)
      end
    end

    it "returns a 404 if the customer does not exist" do

      get "/api/v1/customers/999999/subscriptions"
      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error_json = JSON.parse(response.body, symbolize_names: true)
      expect(error_json[:errors]).to be_a(Array)
      expect(error_json[:errors].first.keys).to eq([:title, :detail])
      expect(error_json[:errors].first[:title]).to eq("ActiveRecord::RecordNotFound")
      expect(error_json[:errors].first[:detail]).to eq("Couldn't find Customer with 'id'=999999")
    end
  end
end