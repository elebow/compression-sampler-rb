# frozen_string_literal: true

require_relative "../test_helper"

class TestLz77Encoder < Minitest::Test
  def test_encode
    encoded = Lz77::Encoder.new("abcabcdabc".bytes, window_size: 9).encode.to_a

    assert_equal [97, 98, 99, [3, 3], 100, [4, 3]], encoded
  end
end
