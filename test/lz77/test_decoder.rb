# frozen_string_literal: true

require_relative "../test_helper"
require "lz77/decoder"

class TestLZ77Decoder < Minitest::Test
  def test_decode
    decoded = LZ77::Decoder.decode(
      [LZ77::SymbolLiteral.new(97),
       LZ77::SymbolLiteral.new(98),
       LZ77::SymbolLiteral.new(99),
       LZ77::SymbolReference.new(offset: 3, length: 3),
       LZ77::SymbolLiteral.new(100),
       LZ77::SymbolReference.new(offset: 4, length: 3)]
    ).to_a

    assert_equal "abcabcdabc", decoded.map(&:chr).join
  end
end
