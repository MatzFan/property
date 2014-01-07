# require 'open-uri'
require 'curb'

URL_ROOT = 'https://www.mygov.je/Planning/Pages/PlanningApplication'
DIV = '<span id="ctl00_SPWebPartManager1_g_cfcbb358_c3fe_4db2_9273_0f5e5f1320'+
      '83_ctl00_lbl'
ITEMS = %w[Reference Category Status Officer Applicant Description
           ApplicationAddress RoadName Parish PostCode Constraints Agent]

class AppScraper

  def initialize
    @app_list = []
  end

  def scrape(app_list)
    app_list.each do |ref|
      details = get_page(app_ref, 'Detail')
      timeline = get_page(app_ref, 'Timeline')
    end
  end

  def get_page(app_ref, type)
    app_url = "#{URL_ROOT}#{type}.aspx?s=1&r=" + app_ref
    source = Curl.get(app_url).body_str
  end

  def parse_details(source)
    table_data = source.split('pln-app')[1] # middle section of 3 is of interest
    table_split = table_data.split(DIV)
    ITEMS.each_with_index do |item, i|
      data = table_split[i + 1].split('<').first
      @app_details << data.split('>').last
    end
    @app_details << parse_coords(source)
    @app_details
  end

  def parse_coords(source)

  end

end # of class

scraper = AppScraper.new
scraper.scrape(["P/2013/1874"]).each {|data| puts data}
