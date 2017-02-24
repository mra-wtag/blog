class ContentsController < ApplicationController
  before_action :set_content, only: [:show, :edit, :update, :destroy]

  def index
    @contents = Content.all
  end

  def new
    @content = Content.new
  end

  def create
    @content = Content.new(content_params)
    if @content.save
      redirect_to action: 'index'
    else
      redirect_to @content
    end
  end

  def update
    if @content.update(content_params)
      flash[:notice] = 'Content was Successfully Edited.'
      render 'show'
    else
      redirect_to @content
    end
  end

  def destroy
    @content.destroy
    flash[:notice] = 'Content was successfully destroyed.'
    redirect_to contents_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content
      @content = Content.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def content_params
      params.fetch(:content, {}).permit(:title, :body)
    end
end
