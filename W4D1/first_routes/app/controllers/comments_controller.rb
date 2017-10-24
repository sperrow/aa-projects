class CommentsController < ApplicationController
  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      render json: user.comments
    elsif params[:artwork_id]
      artwork = Artwork.find(params[:artwork_id])
      render json: artwork.comments
    else
      render plain: 'Provide user or artwork id', status: :unprocessable_entity
    end
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save!
      render json: comment
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      render json: comment
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :artwork_id, :body)
  end
end
