# frozen_string_literal: true

module MTF
  # Encodes printable ASCII characters using move-to-front transformation.
  class Encoder
    attr_reader :alphabet

    def initialize(alphabet: (32..126).map(&:chr))
      @alphabet = alphabet
    end

    def encode(input)
      alphabet = @alphabet.dup

      Enumerator.new do |y|
        input.each_char do |ch|
          y << alphabet.index(ch)
          alphabet.delete(ch)
          alphabet.prepend(ch)
        end
      end
    end
  end
end
