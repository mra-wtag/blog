class ContentsController < ApplicationController
  before_action :set_content, only: [:show, :edit, :update, :destroy]

  def index
    @posts = session[:personal_posts] ? current_user.contents : Content.all
  end

  def new
    @content = Content.new
  end

  def create
    @content = Content.new(content_params)
    @content.user = current_user
    if @content.save
      redirect_to action: 'index'
    else
      redirect_to @content
    end
  end

  def personal_posts
    session[:personal_posts] = true
    redirect_to contents_url
  end

  def update
    if @content.update(content_params)
      flash[:notice] = t 'notice.edit'
      render 'show'
    else
      redirect_to @content
    end
  end

  def destroy
    @content.destroy
    flash[:notice] = t 'notice.destroy'
    redirect_to contents_url
  end

  private
    def set_content
      @content = Content.find(params[:id])
    end

    def content_params
      params.fetch(:content, {}).permit(:title, :body)
    end
end
