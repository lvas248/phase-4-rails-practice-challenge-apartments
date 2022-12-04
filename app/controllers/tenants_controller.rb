class TenantsController < ApplicationController
    wrap_parameters format: []

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
        
    def index
            render json: Tenant.all, status: :ok
        end
    
        def show
            tenant = find_tenant
            render json: tenant, status: :ok
        end
    
        def create
            tenant = Tenant.create!(tenant_params)
            render json: tenant, status: :created
        end
    
        def update
            tenant = find_tenant
            tenant.update!(tenant_params)
            render json: tenant, status: :ok
        end
    
        def destroy
            tenant = find_tenant
            tenant.destroy
            head :no_content
        end
    
        private
    
        def find_tenant
            Tenant.find(params[:id])
        end
    
        def tenant_params
            params.permit(:name, :age, :id)
        end
    
        def render_not_found
            render json: {error: "Tenant not found"}
        end
    
        def render_invalid(invalid)
            render json: {errors: invalid.record.errors.full_messages}
        end
    end