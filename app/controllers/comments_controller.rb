class CommentsController < ApplicationController

before_filter :require_user

  def index  
    @comments = Comment.includes(:post).where(:checked => false)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

def checked
    @comment = Comment.find(params[:id])
    @comment.checked = true
    @comment.save
    
    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :ok }
    end  
  
end

def destroy
    @comment = Comment.find(params[:id])
    @comment .destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :ok }
    end  
end

end
