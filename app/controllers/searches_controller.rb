class SearchesController < ApplicationController
    def index
      if params[:search_method] == "Book"
        @books = Book.search(params[:search_way],params[:search])
      else
        @users = User.search(params[:search])
      end

    end
end
