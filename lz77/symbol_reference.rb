# frozen_string_literal: true

module LZ77
  class SymbolReference
    def initialize(offset, length)
      @offset = offset
      @length = length
    end

    def to_s
      @value
    end
  end
end
