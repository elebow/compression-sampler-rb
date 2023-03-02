# frozen_string_literal: true

require_relative "../test_helper"

class TestHuffmanCanonicalizer < Minitest::Test
  def test_canonical_dict
    writer = Deflate::HuffmanWriter.new(
      { 97 => "0",
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
        32 => "111" }
    )

    assert_equal(
      { 1 => [97, 101],
        3 => [116, 104, 105, 115, 32],
        4 => [110, 109, 102],
        5 => [120, 112, 108, 111, 117, 114] },
      writer.send(:canonical_dict)
    )
  end
end
