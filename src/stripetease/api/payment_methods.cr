module Stripetease
  module API
    # PaymentMethod objects represent your customer's payment instruments.
    # You can use them with PaymentIntents to collect payments or save them to Customer objects to store instrument details for future payments.
    class PaymentMethods
      def initialize(@session : Session)
      end

      # Retrieves a PaymentMethod object attached to the StripeAccount.
      def get(id : String)
        JSON.parse(@session.get("/v1/payment_methods/#{id}").body)
      end

      # Retrieves a PaymentMethod object for a given Customer.
      def get(customer_id : String)
        JSON.parse(@session.get("/v1/customers/#{customer_id}/payment_methods").body)
      end

      # Returns a list of PaymentMethods attached to the StripeAccount.
      def list(type : String, customer : String? = nil, ending_before : String? = nil, limit : Int32? = nil, starting_after : String? = nil)
        io = IO::Memory.new
        builder = ParameterBuilder.new(io)

        {% for x in %w(type customer ending_before limit starting_after) %}
          builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
        {% end %}

        JSON.parse(@session.get("/v1/payment_methods", raw: io.to_s).body)
      end

      # Returns a list of PaymentMethods for a given Customer.
      def list_by_customer_id(customer_id : String, **kwargs)
        JSON.parse(@session.get("/v1/customers/#{customer_id}/payment_methods", form: kwargs).body)
      end

      # Creates a PaymentMethod object.
      def create(type : String, billing_details : Hash? = nil, metadata : Hash? = nil, acss_debit : Hash? = nil, affirm : Hash? = nil, afterpay_clearpay : Hash? = nil, alipay : Hash? = nil, au_becs_debit : Hash? = nil, bacs_debit : Hash? = nil, bancontact : Hash? = nil, blik : Hash? = nil, boleto : Hash? = nil, card : Hash? = nil, customer_balance : Hash? = nil, eps : Hash? = nil, fpx : Hash? = nil, giropay : Hash? = nil, ideal : Hash? = nil, interac_present : Hash? = nil, klarna : Hash? = nil, konbini : Hash? = nil, link : Hash? = nil, oxxo : Hash? = nil, p24 : Hash? = nil, paynow : Hash? = nil, promptpay : Hash? = nil, radar_options : Hash? = nil, sepa_debit : Hash? = nil, sofort : Hash? = nil, us_bank_account : Hash? = nil, wechat_pay : Hash? = nil)
        io = IO::Memory.new
        builder = ParameterBuilder.new(io)

        {% for x in %w(type billing_details metadata acss_debit affirm afterpay_clearpay alipay au_becs_debit bacs_debit bancontact blik boleto card customer_balance eps fpx giropay ideal interac_present klarna konbini link oxxo p24 paynow promptpay radar_options sepa_debit sofort us_bank_account wechat_pay) %}
          builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
        {% end %}

        JSON.parse(@session.post("/v1/payment_methods", raw: io.to_s).body)
      end

      # Updates a PaymentMethod object.
      # A PaymentMethod must be attached a customer to be updated.
      def update(id : String, billing_details : Hash? = nil, metadata : Hash? = nil, card : Hash? = nil, link : Hash? = nil, us_bank_account : Hash? = nil)
        io = IO::Memory.new
        builder = ParameterBuilder.new(io)

        {% for x in %w(billing_details metadata card link us_bank_account) %}
          builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
        {% end %}

        JSON.parse(@session.post("/v1/payment_methods/#{id}", raw: io.to_s).body)
      end
    end
  end
end
