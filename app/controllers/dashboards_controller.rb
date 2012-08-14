class DashboardsController < ApplicationController

  def index
    @speclines = Specline.count
    @recent_speclines = Specline.where('created_at > ?', 1.day.ago).count
    if @recent_speclines.blank?
      @recent_speclines = 0
    end
    
    @changes = Change.count
    @recent_changes = Change.where('created_at > ?', 1.day.ago).count
    if @recent_changes.blank?
      @recent_changes = 0
    end 
       
    @posts = Post.count
    @recent_posts = Post.where('created_at > ?', 1.day.ago).count
    if @recent_posts.blank?
      @recent_posts = 0
    end
   
    @comments = Comment.count
    @recent_comments = Comment.where('created_at > ?', 1.day.ago).count
    if @recent_comments.blank?
      @recent_comments = 0
    end
        
    @accounts = Account.count
     if @recent_accounts.blank?
      @recent_accounts = 0
    end 
      
    @users = User.count
    @recent_users = User.where('created_at > ?', 1.day.ago).count
    if @recent_users.blank?
      @recent_users = 0
    end 
       
    @txt3s = Txt3.count
    @recent_txt3s = Txt3.where('created_at > ?', 1.day.ago).count
    if @recent_txt3s.blank?
      @recent_txt3s = 0
    end 
       
    @txt4s = Txt4.count
    @recent_txt4s = Txt4.where('created_at > ?', 1.day.ago).count
    if @recent_txt4s.blank?
      @recent_txt4s = 0
    end
        
    @txt5s = Txt5.count
    @recent_txt5s = Txt5.where('created_at > ?', 1.day.ago).count
    if @recent_txt5s.blank?
      @recent_txt5s = 0
    end
        
    @clausetitles = Clausetitle.count
  end

end
