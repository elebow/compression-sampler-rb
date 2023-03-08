# frozen_string_literal: true

require_relative "../test_helper"
require "lz77/encoder"

class TestLZ77Encoder < Minitest::Test
  def test_encode
    encoded = LZ77::Encoder.new("abcabcdabc".bytes, window_size: 9).encode.to_a

    assert_equal [LZ77::SymbolLiteral.new(97),
                  LZ77::SymbolLiteral.new(98),
                  LZ77::SymbolLiteral.new(99),
                  LZ77::SymbolReference.new(offset: 3, length: 3),
                  LZ77::SymbolLiteral.new(100),
                  LZ77::SymbolReference.new(offset: 4, length: 3)],
                 encoded
  end
end
