# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

#Customers
bob = Customer.create(first_name: "Bob", last_name: "Jones" , email: "bob@example.com", address: "123 Bob St. Bob, CO 80302")
jim = Customer.create(first_name: "Jim", last_name: "Miller" , email: "jim@example.com", address: "123 jim St. Bob, CO 80302")
anna = Customer.create(first_name: "Anna", last_name: "Lee" , email: "anna@example.com", address: "123 anna St. Bob, CO 80302")

#Teas
green = Tea.create(title: "Green Tea", description: "Green tea is green", temperature: 180, brew_time: 3, price: 10)
oolong = Tea.create(title: "Oolong Tea", description: "Oolong tea is oolong", temperature: 200, brew_time: 5, price: 15)
earl_grey = Tea.create(title: "Earl Grey Tea", description: "Earl Grey tea is earl grey", temperature: 212, brew_time: 3, price: 12)

#subscriptions
bob_sub_1 = Subscription.create(title: "Green Tea Subscription", price: 10 , status: 0, frequency: "monthly", customer_id: bob.id, tea_id: green.id)
bob_sub_2 = Subscription.create(title: "Oolong Tea Subscription", price: 15 , status: 0, frequency: "monthly", customer_id: bob.id, tea_id: oolong.id)
jim_sub_1 = Subscription.create(title: "Earl Grey Tea Subscription", price: 12 , status: 0, frequency: "monthly", customer_id: jim.id, tea_id: earl_grey.id)
anna_sub_1 = Subscription.create(title: "Green Tea Subscription", price: 10 , status: 0, frequency: "monthly", customer_id: anna.id, tea_id: green.id)