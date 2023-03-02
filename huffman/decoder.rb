# frozen_string_literal: true

module Huffman
  # Decodes bytes using the specified canonical Huffman code dictionary.
  class Decoder
    attr_accessor :input, :canonical_dictionary

    def self.encode(input, canonical_dictionary:)
      new(input, canonical_dictionary: canonical_dictionary).encode
    end

    def initialize(input, canonical_dictionary:)
      @input = input
      @canonical_dictionary = canonical_dictionary
    end

    def decode
      Enumerator.new do |yielder|
        input.each { |symbol| yielder << dictionary[symbol] }
      end
    end

    private

    def dict
      canonical_dictionary.transform_keys do |key|

      end
    end
  end
end
