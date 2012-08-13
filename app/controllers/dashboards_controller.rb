class DashboardsController < ApplicationController

  def index
    @speclines = Specline.count
    @changes = Change.count
    @posts = Post.count
    
    @txt3s = Txt3.count
    @txt4s = Txt4.count

  end

end
