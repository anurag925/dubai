# frozen_string_literal: true

module Utils
  # class having logic for encoding and decoding jwt for the entire project
  class Timing
    class << self
      def inception
        DateTime.parse('01/01/1970')
      end
    end
  end
end
