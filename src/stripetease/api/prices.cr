module Stripetease
  module API
    # Prices define the unit cost, currency, and (optional) billing cycle for both recurring and one-time purchases of products.
    class Prices
      def initialize(@session : Session)
      end

      # Returns a list of your prices.
      def list(active : Bool? = nil, currency : String? = nil, product : String? = nil, type : String? = nil, created : Hash(String, String)? = nil, ending_before : String? = nil, limit : Int32? = nil, lookup_keys : Array(String)? = nil, recurring : Hash(String, String)? = nil, starting_after : String? = nil)
        io = IO::Memory.new
        builder = ParameterBuilder.new(io)

        {% for x in %w(active currency product type created ending_before limit lookup_keys recurring starting_after) %}
          builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
        {% end %}

        JSON.parse(@session.get("/v1/prices", raw: io.to_s).body)
      end
    end
  end
end
