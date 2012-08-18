task :txt4_scrub => :environment do
  
    speclines = Specline.all.collect{|i| i.txt4_id}.uniq
    changes = Change.all.collect{|i| i.txt4_id}.uniq
    txt4_id_array = Txt4.all.collect{|i| i.id}
    
    unused_txt4_id_array = txt4_id_array - changes - speclines

    @txt4s = Txt4.where(:id => unused_txt4_id_array)
  
  @txt4s.each do |txt4|   
    @txt4s.destroy
  end

end