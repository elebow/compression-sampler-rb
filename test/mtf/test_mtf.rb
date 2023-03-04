# frozen_string_literal: true

require_relative "../test_helper"
require "move_to_front/encoder"
require "move_to_front/decoder"

class TestMTF < Minitest::Test
  def test_encode
    encoder = MTF::Encoder.new
    encoded_numbers = encoder.encode("an example string")

    decoded_str = MTF::Decoder.new(alphabet: encoder.alphabet)
                              .decode(encoded_numbers)
                              .to_a
                              .join

    assert decoded_str == "an example string"
  end
end
