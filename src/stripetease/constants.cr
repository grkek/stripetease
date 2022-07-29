module Stripetease
  module Constants
    VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}

    DEFAULT_SINGLE_REQUEST_TIMEOUT = 60

    STATUS_CODES = {400 => "Bad Request", 402 => "Payment Required"}
  end
end
