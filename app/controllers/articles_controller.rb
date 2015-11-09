class ArticlesController < ApplicationController


  def index
    @articles = Article.all
    @articles = Tag.find(params[:tag]).articles if params[:tag].present?
    @comments = Comment.all
    @filtertagname = Tag.find(params[:tag]).name if params[:tag].present?
  end
  def show
    set_article
    @comment = Comment.new
    @comment.article_id = @article.id
  end

  # def filtered_by_tags
  # @articles = Tag.find(params[:id]).articles
  # end

  def new
    @article = Article.new
    @article.author_id = current_user.username
  end
  def create
    # binding.pry
    @article = Article.new(article_params)
    @article.author_id = current_user.id
    logger.debug 'article params: #{article_params.inspect}'

    respond_to do |format|
      if @article.save
        flash[:success] = 'Article was successfully created.'
        format.html { redirect_to articles_path }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    # logger.debug "deleted article: #{@article.inspect}"
    set_article
    # @article = Article.find(params[:id])
    @article.destroy
    respond_to do |format|
      flash[:success] = 'Todo was successfully destroyed.'
      format.html { redirect_to articles_path }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      logger.debug "find called on article id: #{params[:id]}"
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :body, :author_id, :tag_list)
    end
end
