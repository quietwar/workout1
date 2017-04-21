class ArticlesController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :set_article, only: [:show, :edit, :update, :destroy]
	def index
		@articles = Article.all
	end

	def show
		@chat = @article.chats.build
		@chats = @article.chats
	end

	def new
  		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		@article.user = current_user

		if @article.save
			flash[:success] = "Clap has been created"
			redirect_to articles_path
		else
			flash.now[:alert] = "Clap has not been created"
			render :new
		end
	end

	def edit
		unless @article.user == current_user
			flash_message = "You can only edit your own clap"
			redirect_to root_path
		end
	end

	def update
		unless @article.user == current_user
			flash_message = "You can only edit your own clap"
			redirect_to root_path
	else
		if @article.update(article_params)
			flash[:success] = "Clap has been updated"
			redirect_to @article
		else
			flash.now[:alert] = "Clap has not been updated"
			render :edit
		end
	end
end
		def destroy
			if @article.destroy
				flash[:success] = "Clap has been deleted."
				redirect_to articles_path
			end
	end

	protected

		def resource_not_found
			flash[:alert] = "The clap you are looking for could not be found"
			redirect_to root_path
		end


	private

	def set_article
		@article = Article.find(params[:id])
	end

	def article_params
		params.require(:article).permit(:title, :body)
	end
end
