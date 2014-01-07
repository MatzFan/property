require 'app_scraper'

describe AppScraper do

  let(:scraper) { AppScraper.new}

  context 'initialization' do
    it 'should include a search string list' do
      scraper.should_not be_nil
    end
  end

  context '#get_details_source' do
    it "should return the source of the 'Details' page for an application" do
      scraper.get_details_source('P/2013/1522').should include('P/2013/1522')
    end
  end

end # of describe
