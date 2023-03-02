# frozen_string_literal: true

require_relative "../test_helper"

class TestLz77Decoder < Minitest::Test
  def test_decode
    decoded = Lz77::Decoder.decode([97, 98, 99, [3, 3], 100, [4, 3]]).to_a

    assert_equal "abcabcdabc", decoded.map(&:chr).join
  end
end
