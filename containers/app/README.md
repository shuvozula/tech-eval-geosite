# Landsat COG Service
> My very first Ruby on Rails service!

This service displays a list of Landsat Cloud Optimized GeoTifs (COGs), which are clickable links linking to a preview
of GeoTiff data.

## Seed data
The Landsat COGs are available in XML format from `https://landsat-pds.s3.amazonaws.com/` and they are loaded into the
service's application database via `seeds.rb`. This process takes place when the container image is being built via
`docker-compose`. The reason for this design decision is b/c it does not fetch the XML in each HTTP request, hence the
cached data helps load pages faster by reading the local Sqlite database (could be PostGIS for optimized indices).

### Improvements:
- The Landsat COG XML data could utilize a separate data-pipeline script/service that populates a PostGIS database
container.
- The Database container can be rotated frequently (using blue/green deployment approach) across horizontally scaled out
service plane of Landsat-COG services, watching the traffic for downtime and quickly swapping database connections.
