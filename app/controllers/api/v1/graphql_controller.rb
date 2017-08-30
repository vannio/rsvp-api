module Api::V1
  class GraphqlController < BaseController
    def create
      render json: Schema.execute(
        params[:query],
        variables: query_variables,
        context: {
          authenticate_user: AuthenticateUser,
          authorize_api_req: AuthorizeApiRequest
        }
      )
    end

    private

      def query_variables
        params[:variables] || {}
      end
  end
end
