module Stripetease
  module API
    # This object represents a customer of your business.
    # It lets you create recurring charges and track payments that belong to the same customer.
    class Customers
      def initialize(@session : Session)
      end

      # Retrieves a Customer object.
      def get(id : String)
        JSON.parse(@session.get("/v1/customers/#{id}").body)
      end

      # Returns a list of your customers.
      # The customers are returned sorted by creation date, with the most recent customers appearing first.
      def list(**kwargs)
        JSON.parse(@session.get("/v1/customers", form: kwargs).body)
      end

      # Search for customers you’ve previously created using Stripe’s Search Query Language.
      def search(**kwargs)
        JSON.parse(@session.get("/v1/customers/search", form: kwargs).body)
      end

      def create(account_balance : Int32? = nil, coupon : String? = nil, default_source : String? = nil, description : String? = nil, email : String? = nil, invoice_prefix : String? = nil, metadata : Hash? = nil, shipping : Hash? = nil, source : String? = nil, tax_info : Hash? = nil)
        io = IO::Memory.new
        builder = ParameterBuilder.new(io)

        {% for x in %w(account_balance coupon default_source description email invoice_prefix metadata shipping source tax_info) %}
          builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
        {% end %}

        JSON.parse(@session.post("/v1/customers", raw: io.to_s).body)
      end

      # Updates the specified customer by setting the values of the parameters passed.
      # Any parameters not provided will be left unchanged.
      def update(id : String, customer : String? = nil, account_balance : Int32? = nil, coupon : String? = nil, default_source : String? = nil, description : String? = nil, email : String? = nil, invoice_prefix : String? = nil, metadata : Hash? = nil, shipping : Hash? = nil, source : String? = nil, tax_info : Hash? = nil)
        io = IO::Memory.new
        builder = ParameterBuilder.new(io)

        {% for x in %w(account_balance coupon default_source description email invoice_prefix metadata shipping source tax_info) %}
          builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
        {% end %}

        JSON.parse(@session.post("/v1/customers/#{id}", raw: io.to_s).body)
      end

      # Permanently deletes a customer. It cannot be undone.
      # Also immediately cancels any active subscriptions on the customer.
      def delete(id : String)
        JSON.parse(@session.post("/v1/customers/#{id}/delete").body)
      end
    end
  end
end
