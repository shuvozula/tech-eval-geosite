class CogsController < ApplicationController

  def create
    @landsat_rec = LandsatPds.new(landsat_params)
    @landsat_rec.save
  end

  def list
    @landsat_url = ENV['LANDSAT_URL']
    @landsat_recs = LandsatPds.all
  end

  private
    def landsat_params
      params.require(:landsat_rec).permit(:key,
                                          :last_modified,
                                          :etag,
                                          :size,
                                          :owner_id,
                                          :display_name,
                                          :storage_class,
                                          :created_at,
                                          :updated_at)
    end
end
