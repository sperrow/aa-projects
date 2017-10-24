class ArtworkSharesController < ApplicationController
  def create
    @share = ArtworkShare.new(artwork_share_params)
    if @share.save
      render json: @share
    else
      render json: @share.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @share = ArtworkShare.find(params[:id])
    if @share.destroy
      render json: @share
    else
      render json: @share.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def artwork_share_params
    params.require(:share).permit(:viewer_id, :artwork_id)
  end
end
