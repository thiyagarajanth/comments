class CommentsController < ApplicationController

  def index
    @comments = Comment.lists
    @comment = Comment.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @comment = Comment.new(comment_params.merge(:ip_address => request.remote_ip))
    respond_to do |format|
      if @comment.save
        @comments = Comment.lists
        format.js
      else
        format.html { render :new }
      end
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:notes)
    end
end
