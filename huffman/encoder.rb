# frozen_string_literal: true

require "huffman/tree_node"

module Huffman
  # Encodes bytes using a Huffman code. The output is a dictionary and an array of codes.
  class Encoder
    attr_accessor :input

    def self.encode(input)
      new(input).encode
    end

    def initialize(input)
      @input = input
    end

    def dict
      @dict ||= begin
        dict = {}
        tree.first.report_code(dict, "")
        dict
      end
    end

    def encode
      Enumerator.new do |yielder|
        input.each { |byte| yielder << dict[byte] }
      end
    end

    private

    def frequencies
      @frequencies ||= input.group_by(&:itself)
                            .transform_values(&:count)
    end

    def tree
      @tree ||= begin
        tree = frequencies.map { |symbol, weight| TreeNode.new(symbol, weight: weight) }
                          .sort_by(&:weight)

        while tree.count > 1
          new_node = TreeNode.new(nil, children: tree.shift(2))

          tree.append(new_node)
              .sort_by!(&:weight)
        end
        tree
      end
    end
  end
end
