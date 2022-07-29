module Stripetease
  module API
    # To charge a credit or a debit card, you create a Charge object.
    # You can retrieve and refund individual charges as well as list all charges.
    # Charges are identified by a unique, random ID.
    class Charges
      def initialize(@session : Session)
      end

      # Retrieves the details of a charge that has previously been created.
      def get(id : String)
        JSON.parse(@session.get("/v1/charges/#{id}").body)
      end

      # Returns a list of charges you’ve previously created.
      def list(**kwargs)
        JSON.parse(@session.get("/v1/charges", form: kwargs).body)
      end

      # Search for charges you’ve previously created using Stripe’s Search Query Language.
      def search(**kwargs)
        JSON.parse(@session.get("/v1/charges/search", form: kwargs).body)
      end

      # To charge a credit card or other payment source, you create a Charge object.
      # If your API key is in test mode, the supplied payment source (e.g., card) won’t actually be charged, although everything else will occur as if in live mode. (Stripe assumes that the charge would have completed successfully).
      def create(amount : Int32, currency : String, customer : String? = nil, description : String? = nil, metadata : Hash? = nil, receipt_email : String? = nil, shipping : Hash? = nil, source : String? = nil, statement_descriptor : String? = nil, application_fee_amount : Int32? = nil, capture : Bool? = nil, on_behalf_of : String? = nil, radar_options : Hash? = nil, transfer_data : Hash? = nil, transfer_group : String? = nil)
        io = IO::Memory.new
        builder = ParameterBuilder.new(io)

        {% for x in %w(amount currency customer description metadata receipt_email shipping source statement_descriptor application_fee_amount capture on_behalf_of radar_options transfer_data transfer_group) %}
          builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
        {% end %}

        JSON.parse(@session.post("/v1/charges", raw: io.to_s).body)
      end

      # Updates the specified charge by setting the values of the parameters passed.
      # Any parameters not provided will be left unchanged.
      def update(id : String, customer : String? = nil, description : String? = nil, metadata : Hash? = nil, receipt_email : String? = nil, shipping : Hash? = nil, fraud_details : Hash? = nil, transfer_group : String? = nil)
        io = IO::Memory.new
        builder = ParameterBuilder.new(io)

        {% for x in %w(customer description metadata receipt_email shipping transfer_group) %}
          builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
        {% end %}

        JSON.parse(@session.post("/v1/charges/#{id}", raw: io.to_s).body)
      end

      # Capture the payment of an existing, uncaptured, charge.
      # This is the second half of the two-step payment flow, where first you created a charge with the capture option set to false.
      def capture(id : String, amount : Int32? = nil, receipt_email : String? = nil, statement_descriptor : String? = nil, statement_descriptor_suffix : String? = nil, application_fee_amount : Int32? = nil, transfer_data : Hash? = nil, transfer_group : String? = nil)
        io = IO::Memory.new
        builder = ParameterBuilder.new(io)

        {% for x in %w(amount receipt_email statement_descriptor statement_descriptor_suffix application_fee_amount transfer_data transfer_group) %}
          builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
        {% end %}

        JSON.parse(@session.post("/v1/charges/#{id}/capture", raw: io.to_s).body)
      end
    end
  end
end
