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
      flash[:notice] = t('defaults.message.created')
      redirect_to admin_tags_path
    else
      @tag = Tag.new
      @tags = Tag.all
      flash[:alert] = t('defaults.message.not_created')
      render :index
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      flash[:notice] = t('defaults.message.updated')
      redirect_to admin_tags_path
    else
      flash[:alert] = t('defaults.message.not_updated')
      render :edit
    end
  end

  def destroy
    @tag.destroy
    @tags = Tag.all
    flash[:notice] = t('defaults.message.deleted')
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
