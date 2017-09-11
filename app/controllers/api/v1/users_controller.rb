module Api::V1
  class UsersController < BaseController
    before_action :authenticate_request
    before_action :authenticate_admin, only: [:index, :create, :destroy]
    before_action :authenticate_current_user, only: [:show, :update]
    before_action :set_user, only: [:show, :update, :destroy]

    # GET /users
    def index
      @users = User.all

      render json: @users
    end

    # GET /users/1
    def show
      render json: @user
    end

    # POST /users
    # {
    # 	"user": {
    # 		"first_name": "Van",
    # 		"last_name": "Le",
    # 		"email": "van@getting.married",
    # 		"max_party_size": 2,
    # 		"address_attributes": {},
    # 	  "rsvps_attributes": []
    # 	},
    # 	"password": "gettingmarried"
    # }
    def create
      @user = User.new(user_params)

      if @user.save
        render json: @user, status: :created, location: api_v1_user_url(@user)
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /users/1
    # {
    # 	"user": {
    # 		"address_attributes": {
    #       "id": 1
    #     },
    # 	  "rsvps_attributes": [
    #       {
    #         "id": 2
    #       }
    #     ]
    # 	}
    # }
    def update
      if @user.update(user_params)
        render json: @user
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
        @user = User.find(params[:id]) || User.find(params[:user_id])
      end

      # Only allow a trusted parameter "white list" through.
      def user_params
        params.require(:user).permit(
          :first_name, :last_name, :email, :phone, :max_party_size, :password,
          address_attributes: [:id, :street, :city, :postcode, :country],
          rsvps_attributes: [:id, :event_id, :user_id, :adults, :children, :comments]
        )
      end
  end
end
