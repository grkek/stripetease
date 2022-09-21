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

      # Returns a list of customers.
      def list(email : String? = nil, created : Hash? = nil, ending_before : String? = nil, limit : Int32? = nil, starting_after : String? = nil)
        io = IO::Memory.new
        builder = ParameterBuilder.new(io)

        {% for x in %w(email created ending_before limit starting_after) %}
          builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
        {% end %}

        JSON.parse(@session.get("/v1/customers", raw: io.to_s).body)
      end

      def search(query : String, limit : Int32? = nil, page : Int32? = nil)
        io = IO::Memory.new
        builder = ParameterBuilder.new(io)

        {% for x in %w(query limit page) %}
          builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
        {% end %}

        JSON.parse(@session.get("/v1/customers/search", raw: io.to_s).body)
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
