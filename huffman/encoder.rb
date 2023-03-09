# frozen_string_literal: true

module Huffman
  # Encodes bytes using a Huffman code. The output is a dictionary and an array of codes.
  class Encoder
    attr_accessor :input

    def self.encode(...)
      new(...).encode
    end

    def initialize(input, print_tree_evolution: nil)
      @input = input
      @print_tree_evolution = print_tree_evolution
    end

    def dict
      @dict ||= begin
        dict = {}
        trees.first.report_code(dict, "")
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

    def trees
      @trees ||= begin
        trees = frequencies.map { |symbol, weight| TreeNode.new(symbol:, weight:) }
                           .sort_by(&:weight)

        while trees.count > 1
          new_node = TreeNode.new(symbol: nil, children: trees.shift(2))

          trees.append(new_node)
               .sort_by!(&:weight)

          if @print_tree_evolution
            @print_tree_evolution.puts "\n"
            trees.each { |tree| @print_tree_evolution.puts tree.to_s }
          end
        end
        trees
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

    def to_s
      if leaf_node?
        "(#{symbol || ' '}, #{weight})"
      else
        "(#{symbol || ' '}, #{weight}, (#{children.map(&:to_s).join(', ')}))"
      end
    end
  end
end
