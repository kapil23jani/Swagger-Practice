class Api::V1::UsersController < ApplicationController

  swagger_controller :users, "User Management"
  before_action :set_api_v1_user, only: [:show, :update, :destroy]

  # GET /api/v1/users
  def index
    @api_v1_users = Api::V1::User.all

    render json: @api_v1_users
  end

  # GET /api/v1/users/1
  def show
    render json: @api_v1_user
  end

  # POST /api/v1/users
  swagger_api :create do
    summary "To create user"
    notes "Implementation notes, such as required params, example queries for apis are written here."
    param :form, "user[name]", :string, :required, "Name of user"
    param :form, "user[age]", :integer, :optional, "Age of user"
    param_list :form, "user[status]", :string, :required, "Status of user, can be active or inactive"
    response :success
    response :unprocessable_entity
    response :internalerror
  end

  def create
    @api_v1_user = Api::V1::User.new(api_v1_user_params)

    if @api_v1_user.save
      render json: @api_v1_user, status: :created, location: @api_v1_user
    else
      render json: @api_v1_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/users/1
  def update
    if @api_v1_user.update(api_v1_user_params)
      render json: @api_v1_user
    else
      render json: @api_v1_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/users/1
  def destroy
    @api_v1_user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_user
      @api_v1_user = Api::V1::User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def api_v1_user_params
      params.require(:api_v1_user).permit(:name, :age, :status)
    end
end
