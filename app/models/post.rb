class Post < ActiveRecord::Base
  attr_accessible :text, :title, :topic
end
