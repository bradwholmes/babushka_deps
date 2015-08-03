dep 'git user' do
  requires 'git username', 'git email'
end

dep 'git username', :template => 'git_config' do
  property 'user.name'
  value 'Brad Holmes'
end

dep 'git email', :template => 'git_config' do
  property 'user.email'
  value 'inkspotch@gmail.com'
end
