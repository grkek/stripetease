module Stripetease
  module API
    # Prices define the unit cost, currency, and (optional) billing cycle for both recurring and one-time purchases of products.
    class Prices
      def initialize(@session : Session)
      end

      # Returns a list of your prices.
      def list(**kwargs)
        JSON.parse(@session.get("/v1/prices", form: kwargs).body)
      end
    end
  end
end
