module Api::V1
  class GraphqlController < BaseController
    before_action :authenticate_request

    def create
      render json: Schema.execute(
        params[:query],
        variables: query_variables,
        context: {
          current_user: current_user
        }
      )
    end

    private

      def query_variables
        params[:variables] || {}
      end
  end
end
