require "rails_helper"

RSpec.describe "subscriptions", type: :request do
  describe "POST /api/v1/subscriptions" do
    it " creates a new subscription when given valid paramaters" do
      customer = Customer.create(first_name: "Bob", last_name: "Jones" , email: "bob@bobmail.com", address: "123 Bob St. Bob, CO 80302").id
      tea = Tea.create(title: "Green Tea", description: "Green Tea is green", temperature: 180, brew_time: 3, price: 10).id

      subscription_params = {
          customer_id: customer,
          tea_id: tea,
          frequency: "monthly"
        }

      headers = {"CONTENT_TYPE" => "application/json", 'accept' => 'application/json'}

      post "/api/v1/subscriptions", headers: headers, params: JSON.generate(subscription_params)
      expect(response).to be_successful
      expect(Subscription.all.count).to eq(1)
      
      sub_json = JSON.parse(response.body, symbolize_names: true)[:data]
      subscription = Subscription.last
      expect(sub_json[:id]).to eq(subscription.id.to_s)
      expect(sub_json[:type]).to eq("subscription")
      expect(sub_json[:attributes].keys).to eq([:title, 
                                                :price, 
                                                :status, 
                                                :frequency, 
                                                :customer_id, 
                                                :tea_id])
      expect(sub_json[:attributes][:title]).to be_a(String)
      expect(sub_json[:attributes][:price]).to be_a(Integer)
      expect(sub_json[:attributes][:status]).to be_a(String)
      expect(sub_json[:attributes][:frequency]).to be_a(String)
      expect(sub_json[:attributes][:customer_id]).to eq(customer)
      expect(sub_json[:attributes][:tea_id]).to eq(tea)
    end
  end

  describe "PATCH /api/v1/subscriptions/:id" do
    before :each do
      @customer = Customer.create!(first_name: "Tim", last_name: "Timson" , email: "tim@timmail.com", address: "123 Tim St. Tim, CO 80302").id
      @tea = Tea.create!(title: "Green Tea", description: "Green Tea is green", temperature: 180, brew_time: 3, price: 10).id
      @subscription = Subscription.create!(title: "Green Tea Subscription", price: 10 , status: 0, frequency: "monthly", customer_id: @customer, tea_id: @tea)
    end
    
    it "updates the status of a subscription" do
     subscription_params = {
      status: "canceled"
     }
     headers = {"CONTENT_TYPE" => "application/json", 'accept' => 'application/json'}
     
     patch "/api/v1/subscriptions/#{@subscription.id}", headers: headers, params: JSON.generate(subscription_params)
     expect(response).to be_successful

     sub_json = JSON.parse(response.body, symbolize_names: true)[:data]
     subscription = Subscription.last
     expect(sub_json[:id]).to eq(subscription.id.to_s)
     expect(sub_json[:type]).to eq("subscription")
     expect(sub_json[:attributes].keys).to eq([:title,
                                                :price,
                                                :status,
                                                :frequency,
                                                :customer_id,
                                                :tea_id])
      expect(sub_json[:attributes][:title]).to be_a(String)
      expect(sub_json[:attributes][:price]).to be_a(Integer)
      expect(sub_json[:attributes][:status]).to be_a(String)
      expect(sub_json[:attributes][:frequency]).to be_a(String)
      expect(sub_json[:attributes][:customer_id]).to eq(@customer)
      expect(sub_json[:attributes][:tea_id]).to eq(@tea)

      expect(subscription.status).to eq("canceled")
    end

    it "will not update the status of a subscription if given invalid status" do
      invalid_sub_params = {
        status: "not a valid status"
      }
      headers = {"CONTENT_TYPE" => "application/json", 'accept' => 'application/json'}

      patch "/api/v1/subscriptions/#{@subscription.id}", headers: headers, params: JSON.generate(invalid_sub_params)
      expect(response).to_not be_successful
      expect(response.status).to eq(422)
      
      error_json = JSON.parse(response.body, symbolize_names: true)[:errors].first
      expect(error_json.keys).to eq([:title, :detail])
      expect(error_json[:title]).to eq("ArgumentError")
      expect(error_json[:detail]).to eq("'not a valid status' is not a valid status")
     
      expect(@subscription.status).to eq("active")
    end
  end
end