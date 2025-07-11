require_relative "test_helper"

require "byebug"

class Testfunders < Test::Unit::TestCase

  def test_funders_list
    VCR.use_cassette("test_funders_list") do
      res = Syconium.funders(email: "gdower@illinois.edu", per_page: 5)
      assert_equal(1, res["meta"]["page"])
      assert_equal(res["results"].length, 5)
    end
  end

  def test_funders_id
    VCR.use_cassette("test_funders_id") do
      res = Syconium.funders(email: "gdower@illinois.edu", id: "ror:021nxhr62")
      assert_equal(res['display_name'], "National Science Foundation")
    end
  end

  def test_funders_filter
    VCR.use_cassette("test_funders_filter") do
      res = Syconium.funders(email: "gdower@illinois.edu", filter: "country_code:US", per_page: 5)
      assert_equal(res["meta"]["per_page"], 5)
      res["results"].each do |funder|
        assert_equal(funder["country_code"], "US")
      end
    end
  end

  def test_funders_search
    VCR.use_cassette("test_funders_search") do
      res = Syconium.funders(email: "gdower@illinois.edu", search: "biodiversity", per_page: 5)
      assert_equal(res["meta"]["per_page"], 5)
      res["results"].each do |funder|
        assert_true(funder["display_name"].downcase.include?("biodiversity"))
      end
    end
  end
end