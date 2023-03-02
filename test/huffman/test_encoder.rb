# frozen_string_literal: true

require_relative "../test_helper"

class TestHuffmanEncoder < Minitest::Test
  def test_encode
    encoder = Huffman::Encoder.new("this is an example of a huffman tree".bytes)

    assert_equal({ 97 => "0",
                   101 => "1",
                   116 => "100",
                   104 => "101",
                   105 => "110",
                   115 => "111",
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
      %w[100 101 110 111 111 110 111 111 0 1000 111 1 10100 0 1001 10101 10110 1 111 10111 1101 111 0 111 101 11000 1101
         1101 1001 0 1000 111 100 11001 1 1],
      encoder.encode.to_a
    )
  end
end
