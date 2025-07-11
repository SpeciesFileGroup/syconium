require_relative "test_helper"

require "byebug"

class TestWorks < Test::Unit::TestCase

  def test_works_list
    VCR.use_cassette("test_works_list") do
      res = Syconium.works(email: "gdower@illinois.edu")
      assert_equal(1, res["meta"]["page"])
    end
  end

  def test_works_id
    VCR.use_cassette("test_works_id") do
      res = Syconium.works(email: "gdower@illinois.edu", id: "doi:10.3897/biss.4.59130")
      assert_equal(res['title'], "Adding Taxonomic Dimensions to the Scientific Names Index in the Biodiversity Heritage Library via Integration with the Catalogue of Life")
    end
  end

  def test_works_filter
    VCR.use_cassette("test_works_filter") do
      res = Syconium.works(email: "gdower@illinois.edu", filter: "is_oa:true", per_page: 5)
      assert_equal(res["meta"]["per_page"], 5)
      res["results"].each do |work|
        assert_true(work["open_access"]["is_oa"])
      end
    end
  end

  def test_works_search
    VCR.use_cassette("test_works_search") do
      res = Syconium.works(email: "gdower@illinois.edu", search: "biodiversity", per_page: 5)
      assert_equal(res["meta"]["per_page"], 5)
      res["results"].each do |work|
        assert_true(work["title"].downcase.include?("biodiversity"))
      end
    end
  end
end