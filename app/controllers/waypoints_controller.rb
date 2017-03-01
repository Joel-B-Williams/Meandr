class WaypointsController < ApplicationController

  def create
    p "X" * 150
    p "HERE"
    p params
    @waypoint = Waypoint.new(location: "POINT(#{params[:location][:lng]}) #{params[:location][:lat]} ")
    p @waypoint
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
