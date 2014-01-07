# require 'open-uri'
require 'curb'

URL_ROOT = 'https://www.mygov.je/Planning/Pages/PlanningApplication'
DIV = '<span id="ctl00_SPWebPartManager1_g_cfcbb358_c3fe_4db2_9273_0f5e5f1320'+
      '83_ctl00_lbl'
ITEMS = %w[Reference Category Status Officer Applicant Description
           ApplicationAddress RoadName Parish PostCode Constraints Agent]

class AppScraper

  def initialize
    @app_details = []
  end

  def get_details_source(app_ref)
    app_url = "#{URL_ROOT}Detail.aspx?s=1&r=" + app_ref
    source = Curl.get(app_url).body_str
  end

  def parse_details(app_ref)
    # source = get_details_source(app_ref)
    table_data = source.split('pln-app')[1] # middle section of 3 is of interest
    table_split = table_data.split(DIV)
    ITEMS.each_with_index do |item, i|
      data = table_split[i + 1].split('<').first
      @app_details << data.split('>').last
    end
    @app_details
  end

end # of class

s = AppScraper.new
s.parse_details("P/2013/0123").each {|data| puts data}
