require 'pc_scraper'

describe PC_Scraper do

  let(:scraper) { PC_Scraper.new('avenue')}

  context 'initialization' do
    it 'should include a search string' do
      scraper.should_not be_nil
    end
  end

end # of describe
