class CommentsController < ApplicationController
  

  # GET /comments
  # GET /comments.json
  def index
#     ids = Comment.find_by_sql("SELECT array_to_string(array_agg(id), ',') as id, count(*) as cnt, 
# to_timestamp(floor((extract('epoch' from created_at) / 300 )) * 300) 
# as interval_alias
# FROM comments GROUP BY interval_alias  order by 1,2").map(&:id)
    @comments = Comment.all#.where(:id =>ids).order(:id => :desc)
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.js #{ render 'new_book_row', :format => :html, :layout => false }
      format.json { render json: @comment }
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params.merge(:ip_address => request.remote_ip))
    
    ids = Comment.find_by_sql("SELECT array_to_string(array_agg(id), ',') as id, count(*) as cnt, 
            to_timestamp(floor((extract('epoch' from created_at) / 300 )) * 300) 
            as interval_alias
            FROM comments GROUP BY interval_alias  order by 1,2").map(&:id)    
    @comments = Comment.where(:id =>ids).order(:id => :desc)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
        format.js
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:notes, :ip_address)
    end
end
