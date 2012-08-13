module AccountsHelper
  
  def active_licences(account)
       users_array = User.where(:company_id => account.company_id).collect{|i| i.id}
     active_licence_no = Licence.where(:user_id => users_array, :active_licence => true).count
  end
  
end
