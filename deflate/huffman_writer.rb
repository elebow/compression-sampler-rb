# frozen_string_literal: true

module Deflate
  # Writes a Huffman code (dict) to a string in the form specified by Deflate
  class HuffmanWriter
    attr_accessor :dict

    def self.write(dict)
      new(dict).write
    end

    def initialize(dict)
      @dict = dict
    end

    # RFC-1951 section 3.2.7

    private

    def canonical_dict
      # Construct a dictionary of the form { code_length => [ array, of, symbols] }
      # This assumes the input dictionary codes have been assigned canonically.
      @canonical_dict ||= begin
        c_dict = Hash.new { |h, k| h[k] = [] }
        dict.each do |symbol, code|
          c_dict[code.length].append(symbol)
        end
        c_dict
      end
    end
  end
end
