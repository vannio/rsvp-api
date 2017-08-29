class UsersController < ApplicationController
  before_action :authenticate_request
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: full_user
  end

  # POST /users
  def create
    # {
    # 	"user": {
    # 		"first_name": "Van",
    # 		"last_name": "Le",
    # 		"email": "van@getting.married",
    # 		"max_party_size": 2,
    # 		"address_attributes": {},
    # 	  "rsvps_attributes": []
    # 	},
    # 	"password": "gettingmarried",
    # 	"password_confirmation": "gettingmarried"
    # }
    @user = User.new(user_params)

    if @user.save
      render json: full_user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: full_user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(
        :first_name, :last_name, :email, :phone, :max_party_size, :password, :password_confirmation,
        address_attributes: [:id, :street, :city, :postcode, :country],
        rsvps_attributes: [:id, :event_id, :user_id, :adults, :children, :comments]
      )
    end

    def full_user
      @user
        .slice(:id, :first_name, :last_name)
        .merge({
          contact: @user.slice(:phone, :email).merge({
            address: @user.address.try(:slice, :id, :street, :city, :postcode, :country)
          })
        })
        .merge({
          rsvps: @user.rsvps.map do |rsvp|
            {
              id: rsvp.id,
              event: rsvp.event.title,
              response: rsvp.created_at < rsvp.updated_at ? rsvp.slice(:adults, :children, :comments) : nil
            }
          end
        })
    end
end
