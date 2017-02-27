class WaypointsController < ApplicationController

  def create
    @waypoint = Waypoint.new(location: "POINT(#{params[:location][:lat]} #{params[:location][:lng]})")
    if @waypoint.save
      if request.xhr?
        "hello"
      end
    else
      status 404
      alert('did not save')
    end
  end

end
