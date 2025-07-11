require_relative "test_helper"

require "byebug"

class TestAuthors < Test::Unit::TestCase

  def test_authors_list
    VCR.use_cassette("test_authors_list") do
      res = Syconium.authors(email: "gdower@illinois.edu")
      assert_equal(1, res["meta"]["page"])
    end
  end

  def test_authors_id
    VCR.use_cassette("test_authors_id") do
      res = Syconium.authors(email: "gdower@illinois.edu", id: "orcid:0000-0002-9770-2345")
      assert_equal(res['display_name'], "Geoffrey Ower")
    end
  end

  def test_authors_filter
    VCR.use_cassette("test_authors_filter") do
      res = Syconium.authors(email: "gdower@illinois.edu", filter: "has_orcid:true", per_page: 5)
      assert_equal(res["meta"]["per_page"], 5)
      res["results"].each do |author|
        assert_not_nil(author["orcid"])
      end
    end
  end

  def test_authors_search
    VCR.use_cassette("test_authors_search") do
      res = Syconium.authors(email: "gdower@illinois.edu", search: "Geoffrey Ower", per_page: 5)
      assert_equal(res["meta"]["per_page"], 5)
      res["results"].each do |author|
        assert_true(author["display_name"].include?("Geoffrey Ower"))
      end
    end
  end
end