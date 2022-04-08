class Api::LinksController < Api::BaseController
  before_action :request_authorize

  def index
    current_user.links.order(:created_at).page(params[:p])
  end

  def create
    @link = current_user.links.build({ url: link_params[:url], slug: ShortenUrlService.execute(:shorten_url, link_params.to_h)})

    if @link.save
      render json: { data: @link.to_json }, status: :ok
    else
      render json: { message: "Link was failed created" }, status: :unprocessable_entity
    end
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end
end