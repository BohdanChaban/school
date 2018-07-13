# frozen_string_literal: true

class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @articles = Article.all.order(id: :desc).limit(10)
  end

  def show
    @article = Article.find(params[:id])
  end
end
