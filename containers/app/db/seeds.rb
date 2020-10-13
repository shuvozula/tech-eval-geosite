# This seed script needs to be externalized as a data-pipeline script that populates
# the application DB and rotates it intermittently.

require 'open-uri'
require 'active_record/fixtures'

# Load all the Landsat GeoTif URLs and details into Database
landsat_url = ENV["LANDSAT_URL"]
landsat_xml = Nokogiri::XML(URI.open(landsat_url)) do |config|
  config.nononet
end

landsat_xml.xpath('//xmlns:Contents').each do |landsat|
  key = landsat.at_xpath('xmlns:Key').content
  if key.ends_with? ".TIF"
    LandsatPds.seed do |rec|
      key = landsat.at_xpath('xmlns:Key').content
      rec.key = key
      rec.last_modified = DateTime.strptime(landsat.at_xpath('xmlns:LastModified').content, '%Y-%m-%dT%H:%M:%S.000Z')
      rec.etag = landsat.at_xpath('xmlns:ETag').content.tr('"', '')
      rec.size = landsat.at_xpath('xmlns:Size').content
      rec.owner_id = landsat.children.at_xpath('xmlns:ID').content
      rec.display_name = landsat.children.at_xpath('xmlns:DisplayName').content
      rec.storage_class = landsat.at_xpath('xmlns:StorageClass').content
      rec.fetch_url = CGI::escape("#{landsat_url}#{key}")
    end
  end
end
