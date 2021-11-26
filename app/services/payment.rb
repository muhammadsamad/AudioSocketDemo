class Payment
  require "braintree"

  def self.gateway
    gateway = Braintree::Gateway.new(
      environment: :sandbox,
      merchant_id: ENV["MERCHANT_ID"],
      public_key: ENV["PUBLIC_KEY"],
      private_key: ENV["PRIVATE_KEY"],
    )
  end

  def self.generate_token
    return gateway.client_token.generate
  end

  def self.payment( method)
    result = gateway.transaction.sale(
      amount: "100.0",
      payment_method_nonce: method,
      options: {
        submit_for_settlement: true
      }
    )
    result
  end
end
