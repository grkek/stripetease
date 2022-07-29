module Stripetease
  module API
    # This is an object representing your Stripe balance.
    # You can retrieve it to see the balance currently on your Stripe account.
    class Balance
      def initialize(@session : Session)
      end

      # Retrieves the current account balance, based on the authentication that was used to make the request.
      def get
        JSON.parse(@session.get("/v1/balance").body)
      end
    end
  end
end
