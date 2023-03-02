# frozen_string_literal: true

module Lz77
  # Searches a RecentWindow for the longest (and secondarily, most recent) candidate reference target.
  class RecentMatchSearch
    attr_reader :recent_window, :byte_sequence

    def initialize(recent_window, byte_sequence)
      # byte sequence is an enumerator
      @recent_window = recent_window
      @byte_sequence = byte_sequence
    end

    def longest_match
      candidate_matches.max do |a, b|
        comp_result = a[:length] <=> b[:length]

        if comp_result.zero?
          # In case of a tie, we want the most recent (reversed comparison)
          comp_result = b[:offset] <=> a[:offset]
        end

        comp_result
      end
    end

    private

    def candidate_matches
      # This could be optimized with the Rabin--Karp algorithm
      window_data.each_with_index
                 .map do |_value, i|
                   byte_sequence.rewind

                   {
                     offset: window_data.length - i,
                     length: length_of_candidate_match(i)
                   }
                 end
                 .append({ offset: 0, length: 0 }) # default case when there are no matches (or the window is empty)
    end

    def window_data
      recent_window.data
    end

    def length_of_candidate_match(index)
      n = 0
      candidate_sequence = window_data[index..].to_enum

      begin
        n += 1 while byte_sequence.next == candidate_sequence.next
      rescue StopIteration
      end

      n
    end
  end
end
