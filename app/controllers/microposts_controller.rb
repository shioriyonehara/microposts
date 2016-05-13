class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
      render 'static_pages/home'
    end
  end
  
  def retweet
    #@micropost = current_user.microposts.find_by(id: params[:id])
    #return redirect_to root_url if @micropost.nil?
    @retweet_micropost = Micropost.find(params[:id])
    @retweet_id = @retweet_micropost.id
    @retweet_content = @retweet_micropost.content
    # ↓ログイン中のユーザの投稿としてリツイート記事を作成保存する
    @retweet = current_user.microposts.create!(user_id: current_user.id, 
                                               retweet_id: @retweet_id,
                                               content: @retweet_content)
    flash[:success] = "Micropost retweet!"
    redirect_to root_url
  end
  
  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url if @micropost.nil?
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end
  
  private
  def micropost_params
    params.require(:micropost).permit(:content)
  end
end
