class PicturesController < ApplicationController
  before_action :set_picture, only:[:edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @pictures = Picture.all
  end

  def new
    if params[:back]
    @picture = Picture.new(pictures_params)
    else
    @picture = Picture.new
    end
  end

  def create
    @picture = Picture.new(pictures_params)
    @picture.user_id = current_user.id
    if @picture.save
    redirect_to pictures_path,notice:"写真を投稿しました！"
     NoticeMailer.sendmail_picture(@picture).deliver
    else
    render'new'
    end
  end

  def edit
  end

  def update
    @picture.update(pictures_params)
    redirect_to pictures_path,notice:"投稿を更新しました！"
  end

  def destroy
    @picture.destroy
    redirect_to pictures_path,notice:"投稿を削除しました！"
  end

  def confirm
    @picture = Picture.new(pictures_params)
    render :new if @picture.invalid?
  end

  def complete
    @picture.image.retrieve_from_cache! params[:cache][:image]
    @picture.save!
  end

  private
  def pictures_params
    params.require(:picture).permit(:title,:content, :image, :image_cache)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end

end
