class LinksController < ApplicationController
  before_action :set_link, only: %i[ show edit update destroy ]

  def index
    @links = current_user.links.order(:created_at).page(params[:p])
  end

  def show
  end

  def new
    @link = Link.new
  end

  def edit
  end

  def create
    @link = current_user.links.build({ url: link_params[:url], slug: ShortenUrlService.execute(:shorten_url, link_params.to_h)})

    if @link.save
      redirect_to link_url(@link), notice: "Link was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @link.update(link_params)
      redirect_to link_url(@link), notice: "Link was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @link.destroy
    redirect_to links_url, notice: "Link was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def link_params
      params.require(:link).permit(:url)
    end
end
