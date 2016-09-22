class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :correct_user,   only: [:destroy, :edit, :update]

  def show
    @micropost = Micropost.find(params[:id])
    @comments = @micropost.comments.paginate(page: params[:page])
    # @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def edit
    @micropost = Micropost.find(params[:id])
  end

   def update
    @micropost = Micropost.find(params[:id])
    @micropost.content = params[:micropost][:content]
    if @micropost.save
      flash[:success] = "Edited"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:post_title, :content, :picture)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end