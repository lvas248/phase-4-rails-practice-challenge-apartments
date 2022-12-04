class LeasesController < ApplicationController

    wrap_parameters format: []
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    
    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    end

    def destroy
        lease = find_lease
        lease.destroy
        head :no_content
    end

    private

    def find_lease
        Lease.find(params[:id])
    end

    def lease_params
        params.permit(:id, :rent, :apartment_id, :tenant_id)
    end

    def render_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def render_not_found
        render json: {error: "Lease not found"}, status: :not_found
    end

end
