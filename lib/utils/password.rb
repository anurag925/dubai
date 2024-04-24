# frozen_string_literal: true

module Utils
  # file for encrypting password
  class Password
    attr_reader :pass, :salt, :iters

    def initialize(options)
      @pass  = options[:password]
      @salt  = options[:salt]
      @iters = options[:iters] || 1000
    end

    def self.encrypt(**)
      new(**).encrypt
    end

    def encrypt
      bytes = hash_bytes.unpack('H*')
      bytes.first
    end

    private

    def digest
      @digest ||= ::OpenSSL::Digest.new('SHA1')
    end

    def hash_bytes
      ::OpenSSL::PKCS5.pbkdf2_hmac(pass, salt, iters, digest.length, digest)
    end
  end
end
