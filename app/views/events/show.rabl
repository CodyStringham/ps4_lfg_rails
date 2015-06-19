object @posts
attributes :id, :title, :checkpoint, :event

child :user do
  attributes :gamertag
end

child :event do
  attributes :name, :group_size
end


