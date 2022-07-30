module Stripetease
  module API
    # This is an object representing your Stripe balance.
    # You can retrieve it to see the balance currently on your Stripe account.
    class PaymentIntents
      def initialize(@session : Session)
      end

      # Retrieves the current account balance, based on the authentication that was used to make the request.
      def create(amount : Int32, currency : String, automatic_payment_methods : Hash? = nil, confirm : Bool? = nil, customer : String? = nil, description : String? = nil, metadata : Hash? = nil, off_session : Bool? = nil, payment_method : String? = nil, receipt_email : String? = nil, setup_future_usage : String? = nil, shipping : Hash? = nil, statement_descriptor : String? = nil, statement_descriptor_suffix : String? = nil, application_fee_amount : Int32? = nil, capture_method : String? = nil, confrimation_method : String? = nil, error_on_requires_action : Bool? = nil, mandate : String? = nil, mandate_data : Hash? = nil, on_behalf_of : String? = nil, payment_method_data : Hash? = nil, payment_method_types : Array(String)? = nil, payment_method_options : Hash? = nil, radar_options : Hash? = nil, return_url : String? = nil, transfer_data : Hash? = nil, transfer_group : String? = nil, use_stripe_sdk : Bool? = nil)
        io = IO::Memory.new
        builder = ParameterBuilder.new(io)

        {% for x in %w(amount currency automatic_payment_methods confirm customer description metadata off_session payment_method receipt_email setup_future_usage shipping statement_descriptor statement_descriptor_suffix application_fee_amount capture_method confrimation_method error_on_requires_action mandate mandate_data on_behalf_of payment_method_data payment_method_types payment_method_options radar_options return_url transfer_data transfer_group use_stripe_sdk) %}
          builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
        {% end %}

        JSON.parse(@session.post("/v1/payment_intents", raw: io.to_s).body)
      end

      # Confirm that your customer intends to pay with current or provided payment method.
      # Upon confirmation, the PaymentIntent will attempt to initiate a payment.
      def confirm(id : String, payment_method : String? = nil, receipt_email : String? = nil, setup_future_usage : String? = nil, shipping : Hash? = nil, capture_method : String? = nil, error_on_requires_action : Bool? = nil, mandate : String? = nil, mandate_data : Hash? = nil, off_session : Bool? = nil, payment_method_data : Hash? = nil, payment_method_options : Hash? = nil, payment_method_types : Array(String)? = nil, radar_options : Hash? = nil, return_url : String? = nil, use_stripe_sdk : Bool? = nil)
        io = IO::Memory.new
        builder = ParameterBuilder.new(io)

        {% for x in %w(payment_method receipt_email setup_future_usage shipping capture_method error_on_requires_action mandate mandate_data off_session payment_method_data payment_method_options payment_method_types radar_options return_url use_stripe_sdk) %}
          builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
        {% end %}

        JSON.parse(@session.post("/v1/payment_intents/#{id}/confirm", raw: io.to_s).body)
      end

      # A PaymentIntent object can be canceled when it is in one of these statuses:
      # requires_payment_method, requires_capture, requires_confirmation, requires_action, or processing.
      def cancel(id : String, cancellation_reason : String? = nil)
        io = IO::Memory.new
        builder = ParameterBuilder.new(io)

        {% for x in %w(cancellation_reason) %}
          builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
        {% end %}

        JSON.parse(@session.post("/v1/payment_intents/#{id}/cancel", raw: io.to_s).body)
      end
    end
  end
end
