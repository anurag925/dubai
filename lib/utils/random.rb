# frozen_string_literal: true

module Utils
  # Random has logic related to random generators for the projects
  # it can be random id, random number etc
  class Random
    class << self
      def id
        SecureRandom.uuid_v4
      end
    end
  end
end
