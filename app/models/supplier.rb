class Supplier < ActiveRecord::Base
  has_many :sponsors
  has_attached_file :photo
  
  
  
  Paperclip.interpolates :normalized_image_file_name do |attachment, style|
    attachment.instance.normalized_image_file_name
  end

  def normalized_image_file_name
    "#{self.id}-#{self.video_image_name.gsub( /[^a-zA-Z0-9_\.]/, '_')}"
  end

  validates_attachment :photo,
    :attachment_content_type => { :content_type => ["image/png", "image/jpg", "image/jpeg", "image/gif", "image/bmp"] },
    :size => { :in => 0..1000.kilobytes }

  
end
