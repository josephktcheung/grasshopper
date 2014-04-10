collection @users, root: :users

attributes :id, :first_name, :last_name, :role, :status, :email

node :links do |user|
  user_url(user)
end