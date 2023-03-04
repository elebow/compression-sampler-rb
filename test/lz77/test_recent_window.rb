# frozen_string_literal: true

require_relative "../test_helper"

class TestLZ77RecentWindow < Minitest::Test
  def setup
    @recent_window = LZ77::RecentWindow.new(max_size: 10)
  end

  def test_add_data
    @recent_window.add_bytes("a".bytes)

    assert_equal "a".bytes, @recent_window.data
  end

  def test_add_data_max_size
    @recent_window.add_bytes("abcdefghijkl".bytes)

    assert_equal "cdefghijkl".bytes, @recent_window.data
  end

  def test_longest_match
    @recent_window.add_bytes("abc".bytes)
    @recent_window.add_bytes("abcd".bytes)
    @recent_window.add_bytes("abc".bytes)

    assert_equal({ offset: 7, length: 4 }, @recent_window.longest_match("abcd".bytes.to_enum))
    assert_equal({ offset: 3, length: 3 }, @recent_window.longest_match("abc".bytes.to_enum))
    assert_equal({ offset: 0, length: 0 }, @recent_window.longest_match("m".bytes.to_enum))
  end
end
