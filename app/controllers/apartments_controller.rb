class ApartmentsController < ApplicationController

    wrap_parameters format: []

rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    def index
        render json: Apartment.all, status: :ok
    end

    def show
        apartment = find_apartment
        render json: apartment, status: :ok
    end

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
    end

    def update
        apartment = find_apartment
        apartment.update!(apartment_params)
        render json: apartment, status: :ok
    end

    def destroy
        apartment = find_apartment
        apartment.destroy
        head :no_content
    end

    private

    def find_apartment
        Apartment.find(params[:id])
    end

    def apartment_params
        params.permit(:number, :id)
    end

    def render_not_found
        render json: {error: "Apartment not found"}
    end
end
