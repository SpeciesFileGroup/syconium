require_relative "test_helper"

class TestParse < Test::Unit::TestCase

  def test_version
    VCR.use_cassette("test_version") do
      res = Syconium.version
      assert_match(/^v\d+\.\d+\.\d+$/, res['version'])
    end
  end

end