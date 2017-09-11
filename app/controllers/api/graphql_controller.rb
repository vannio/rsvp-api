module Api
  class GraphqlController < ApplicationController
    before_action :authenticate_request

    def create
      render json: Schema.execute(
        params[:query],
        variables: query_variables,
        context: {
          current_user: current_user,
          authenticate_user: AuthenticateUser,
          authorize_api_req: AuthorizeApiRequest,
          auth_error_msg: "Not Authorized"
        }
      )
    end

    private

      def query_variables
        params[:variables] || {}
      end
  end
end
