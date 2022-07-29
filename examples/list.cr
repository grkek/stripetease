require "../src/stripetease"

Log.setup(:debug)

client = Stripetease::Client.new(base_url: "https://api.stripe.com", api_key: "sk_test_4eC39HqLyjWDarjtT1zdp7dc")

client.payment_methods.create(type: "card", card: {"number" => "4242424242424242", "exp_month" => "7", "exp_year" => "2027", "cvc" => "317"})
client.payment_methods.list(customer: "cus_5imgzoCoMkGduV", type: "card")
