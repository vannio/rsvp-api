module Api::V1
  class GraphqlController < BaseController
    before_action :authenticate_request, if: -> { Rails.env.production? }

    def create
      render json: Schema.execute(
        params[:query],
        variables: query_variables,
        context: {}
      )
    end

    private

      def query_variables
        params[:variables] || {}
      end
  end
end
