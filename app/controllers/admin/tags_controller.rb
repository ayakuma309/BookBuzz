class Admin::TagsController < Admin::BaseController
  before_action :set_tag, only: [:edit, :update, :destroy]

  def index
    @tag = Tag.new
    @tags = Tag.all
  end

  def create
    @tags = Tag.all
    tag = Tag.new(tag_params)
    if tag.save
      flash[:notice] = '新規登録しました'
      redirect_to admin_tags_path
    else
      @tag = Tag.new
      @tags = Tag.all
      flash[:alert] = '入力してください'
      render :index
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      flash[:notice] = '更新しました'
      redirect_to admin_tags_path
    else
      flash[:alert] = '入力してください'
      render :edit
    end
  end

  def destroy
    @tag.destroy
    @tags = Tag.all
    flash[:notice] = '削除しました'
    redirect_to admin_tags_path
  end

  private
  def tag_params
    params.require(:tag).permit(:name)
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end
end
