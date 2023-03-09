# frozen_string_literal: true

module Huffman
  # Encodes bytes using a Huffman code. The output is a dictionary and an array of codes.
  class Encoder
    attr_accessor :input

    def self.encode(...)
      new(...).encode
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
      input.map { |byte| dict[byte] }.lazy
    end

    private

    def frequencies
      @frequencies ||= input.group_by(&:itself)
                            .transform_values(&:count)
    end

    def tree
      @tree ||= begin
        tree = frequencies.map { |symbol, weight| TreeNode.new(symbol:, weight:) }
                          .sort_by(&:weight)

        while tree.count > 1
          new_node = TreeNode.new(symbol: nil, children: tree.shift(2))

          tree.append(new_node)
              .sort_by!(&:weight)
        end
        tree
      end
    end
  end

  class TreeNode
    attr_reader :symbol, :children

    def initialize(symbol:, weight: nil, children: [nil, nil])
      @symbol = symbol
      @weight = weight
      @children = children
    end

    def weight
      if leaf_node?
        @weight
      else
        children.sum(&:weight)
      end
    end

    def report_code(dict, prefix)
      if leaf_node?
        dict[symbol] = prefix
      else
        children[0].report_code(dict, "#{prefix}0")
        children[1].report_code(dict, "#{prefix}1")
      end
    end

    def leaf_node?
      !symbol.nil?
    end
  end
end
