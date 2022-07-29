module Stripetease
  class Client
    Log = ::Log.for(self)

    getter balance : API::Balance
    getter charges : API::Charges
    getter customers : API::Customers
    getter payment_intents : API::PaymentIntents
    getter payment_methods : API::PaymentMethods

    def initialize(base_url : String, api_key : String)
      session = Session.new(base_url, api_key)

      @balance = API::Balance.new(session)
      @charges = API::Charges.new(session)
      @customers = API::Customers.new(session)
      @payment_intents = API::PaymentIntents.new(session)
      @payment_methods = API::PaymentMethods.new(session)
    end
  end
end
