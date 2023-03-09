# frozen_string_literal: true

require "lz77/recent_window"

module LZ77
  SymbolLiteral = Data.define(:value)
  SymbolReference = Data.define(:offset, :length)

  # Encodes bytes using LZ77. The output is an array of SymbolLiterals and SymbolReferences.
  class Encoder
    attr_accessor :input, :recent_window

    def self.encode(...)
      new(...).encode
    end

    def initialize(input, window_size: nil)
      # input is an array of bytes
      @input = input
      @recent_window = LZ77::RecentWindow.new(**{ max_size: window_size }.compact)
    end

    def encode
      Enumerator.new do |yielder|
        until input.empty?
          longest_match = recent_window.longest_match(input.to_enum)

          bytes_processed = input.slice!(0..(longest_match[:length].clamp(1..) - 1))

          if longest_match[:length] < 3
            # For short matches, referencing gives no advantage
            bytes_processed.each { |b| yielder << SymbolLiteral.new(b) }
          else
            yielder << SymbolReference.new(offset: longest_match[:offset], length: longest_match[:length])
          end

          recent_window.add_bytes(bytes_processed)
        end
      end
    end
  end
end
