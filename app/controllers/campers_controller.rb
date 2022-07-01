class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_camper
    rescue_from ActiveRecord::RecordInvalid, with: :render_not_valid_camper

    def index
        campers = Camper.all
        # to_json method overrides serializer method
        render json: campers.to_json(only: [:id, :name, :age])
    end

    def show
        camper = Camper.find(params[:id])
        # render json: camper.to_json(include: :activities)
        render json: camper
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end


    private
  
    def render_not_found_camper
        render json: { error: "Camper not found"}, status: :not_found
    end

    def render_not_valid_camper(e)
        render json: { errors: e.record.errors.full_messages}, status: :unprocessable_entity
    end

    def camper_params
        params.permit(:name, :age)
    end
  
end
