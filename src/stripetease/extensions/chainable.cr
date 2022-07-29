module Halite
  module Chainable
    def get(uri : String, *,
            headers : (Hash(String, _) | NamedTuple)? = nil,
            params : (Hash(String, _) | NamedTuple)? = nil,
            form : (Hash(String, _) | NamedTuple)? = nil,
            json : (Hash(String, _) | NamedTuple)? = nil,
            raw : String? = nil,
            tls : OpenSSL::SSL::Context::Client? = nil) : Halite::Response
      request("get", uri, headers: headers, params: params, form: form, json: json, raw: raw, tls: tls)
    end
  end
end
