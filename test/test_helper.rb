# frozen_string_literal: true

require "minitest/autorun"

$LOAD_PATH.unshift File.expand_path("..", __dir__)
require "lz77/encoder"
require "lz77/decoder"
require "huffman/encoder"
require "deflate/huffman_writer"
#TODO require all
