class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  enum status : {active: 0, pending: 1, canceled: 2}
end
