# frozen_string_literal: true

module Utils
  # class having logic for encoding and decoding jwt for the entire project
  class Jwt
    class << self
      SECRET = Rails.application.credentials.secret_key_base
      ALGORITHM = 'HS256'
      # RSA_PRIVATE_KEY = Rails.application.credentials.private_key
      # ALGORITHM = 'RS256'.freeze

      # Will use private key to sign(KMS)
      # use public key to verify signature
      def encode(payload)
        JWT.encode payload, SECRET, ALGORITHM
      end

      def decode(token)
        payload = JWT.decode(token, SECRET, true, { algorithm: ALGORITHM }).first
        ActiveSupport::HashWithIndifferentAccess.new(payload)
      rescue JWT::ExpiredSignature => e
        # Logger("token signer expired: #{e.message}")
        raise e
      rescue StandardError
        # Logger("unable to decode the token: #{e.message}")
        nil
      end
    end
  end
end
