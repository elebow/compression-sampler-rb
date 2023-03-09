# frozen_string_literal: true

require_relative "../test_helper"
require "huffman/encoder"

class TestHuffmanEncoder < Minitest::Test
  def test_encode
    encoder = Huffman::Encoder.new("this is an example of a huffman tree".bytes)

    assert_equal({ 97 => "000",
                   101 => "001",
                   116 => "0100",
                   104 => "0101",
                   105 => "0110",
                   115 => "0111",
                   110 => "1000",
                   109 => "1001",
                   120 => "10100",
                   112 => "10101",
                   108 => "10110",
                   111 => "10111",
                   117 => "11000",
                   114 => "11001",
                   102 => "1101",
                   32 => "111" }, encoder.dict)
    assert_equal(
      # "this "
      # "is "
      # "an "
      # "example "
      # "of "
      # "a "
      # "huffman "
      # "tree"
      %w[0100 0101 0110 0111 111
         0110 0111 111
         000 1000 111
         001 10100 000 1001 10101 10110 001 111
         10111 1101 111
         000 111
         0101 11000 1101 1101 1001 000 1000 111
         0100 11001 001 001],
      encoder.encode.to_a
    )
  end
end
