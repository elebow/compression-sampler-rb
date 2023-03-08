# frozen_string_literal: true

require "lz77/encoder"

module LZ77
  # Decodes LZ77 data. The input is an array containing SymbolLiterals and SymbolReferences.
  class Decoder
    attr_accessor :input

    def self.decode(input)
      new(input).decode
    end

    def initialize(input)
      @input = input
    end

    def decode
      Enumerator.new do |yielder|
        output = []
        input.each do |element|
          case element
          in SymbolLiteral(value:)
            output.append(value)
          in SymbolReference(length:, offset:)
            length.times { output.append(output[-offset]) }
          end

          # TODO output buffer must be at least as long as the encoder's maximum window size
          # otherwise, the decoder might encounter references that point outside the window
          yielder << output.shift while output.length > 4096
        end

        yielder << output.shift until output.empty?
      end
    end
  end
end
