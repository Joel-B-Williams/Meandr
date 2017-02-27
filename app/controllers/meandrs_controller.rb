class MeandrsController < ApplicationController
  def create
    # p "Patrick & Joel are the shiznit!"
    # p params  # <ActionController::Parameters {"meandr"=>{"startLatitude"=>"41.8760906", "startLongitude"=>"-87.6530576", "endLatitude"=>"41.902839", "endLongitude"=>"-87.70705809999998"}, "controller"=>"meandrs", "action"=>"create"} permitted: false>

    # p meandr_params # <ActionController::Parameters {"startLatitude"=>"41.8760906", "startLongitude"=>"-87.6530576", "endLatitude"=>"41.902839", "endLongitude"=>"-87.70705809999998"} permitted: true>

    if request.xhr?
      # Waypoint.create(location: 'POINT(41.876451 -87.653213)')
      start_point = Waypoint.new(location: "POINT(#{meandr_params[:startLatitude]} #{meandr_params[:startLongitude]})")
      end_point = Waypoint.new(location: "POINT(#{meandr_params[:endLatitude]} #{meandr_params[:endLongitude]})")
      meandr = Meander.new
      # p "*"*50
      meandr_array = meandr.meander(start_point, end_point)
      # p "*"*50
      meandr_coordinates = Meander.assemble_meander_coordinates(meandr_array)
      start_coordinates = start_point.location.coordinates
      end_coordinates = end_point.location.coordinates
      # p "FINISHED RUBY PASSBACK" * 20
      # p meandr_coordinates
      # p start_coordinates
      # p end_coordinates
      render json: { start: start_coordinates, end: end_coordinates, waypoints: meandr_coordinates }
    else
    end
  end

  private

  def meandr_params
    params.require(:meandr).permit(:startLatitude, :startLongitude, :endLatitude, :endLongitude)
  end
end
