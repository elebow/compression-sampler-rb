# frozen_string_literal: true

module Lz77
  class SymbolLiteral
    def initialize(value)
      @value = value
    end

    def to_s
      @value
    end
  end
end