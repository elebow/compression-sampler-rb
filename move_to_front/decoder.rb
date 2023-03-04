# frozen_string_literal: true

module MTF
  # Decodes printable ASCII characters using move-to-front transformation.
  class Decoder
    attr_reader :alphabet

    def initialize(alphabet: (32..126).map(&:chr))
      @alphabet = alphabet
    end

    def decode(input)
      alphabet = @alphabet.dup

      Enumerator.new do |y|
        input.each do |i|
          y << alphabet[i]
          ch = alphabet.delete_at(i)
          alphabet.prepend(ch)
        end
      end
    end
  end
end
