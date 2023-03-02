# frozen_string_literal: true

module Huffman
  class TreeNode
    attr_reader :symbol, :weight, :children

    def initialize(symbol, weight: nil, children: [nil, nil])
      @symbol = symbol
      @weight = if leaf_node?
                  weight
                else
                  children.map(&:weight).reduce(:+)
                end
      @children = children
    end

    def report_code(dict, prefix)
      if leaf_node?
        dict[symbol] = prefix.to_i(2).to_s(2)
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
