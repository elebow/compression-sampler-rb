# frozen_string_literal: true

require "lz77/recent_match_search"

module Lz77
  # Buffer of bytes that have been seen recently, which the encoder can use as a reference target.
  class RecentWindow
    attr_reader :data, :max_size

    def initialize(max_size: 4096)
      @max_size = max_size
      @data = []
    end

    def add_bytes(bytes)
      # Note that we add new bytes to the _end_ and truncate the _beginning_.
      # This lets us search "backwards" through the buffer with Enumerator#next.
      data.concat(bytes)
      @data = data.last(max_size)
    end

    def longest_match(byte_sequence)
      RecentMatchSearch.new(self, byte_sequence).longest_match
    end
  end
end
