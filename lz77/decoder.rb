# frozen_string_literal: true

module Lz77
  # Decodes LZ77 data. The input is an array containing byte literals or 2-tuples of [offset, length] references.
  class Decoder
    attr_accessor :input

    def self.decode(input)
      new(input).decode
    end

    def initialize(input)
      @input = input
    end

    def decode
      Enumerator.new do |yielder|
        output = []
        input.each do |element|
          if element.instance_of?(Integer)
            # element is a literal, so just echo it
            output.append(element)
          else
            # element is a reference of the form [offset, length]
            element[1].times { output.append(output[-element[0]]) }
          end

          # TODO output buffer must be at least as long as the encoder's maximum window size
          # otherwise, the decoder might encounter references that point outside the window
          yielder << output.shift while output.length > 4096
        end

        yielder << output.shift until output.empty?
      end
    end
  end
end
