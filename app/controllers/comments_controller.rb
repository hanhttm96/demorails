class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :correct_user,   only: [:destroy, :edit, :update]

  def new
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to :back
    else
      flash[:success] = "Comment created!"
      render 'new'
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to request.referrer || root_url
  end

  def edit
    @comment = Comment.find(params[:id])
  end

   def update
    @comment = Comment.find(params[:id])
    @comment.cmcontent = params[:comment][:cmcontent]
    if @comment.save
      flash[:success] = "Edited"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:cmcontent, :micropost_id)
    end

    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end
end