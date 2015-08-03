dep 'git push simple', :template => 'git_config' do
  property 'push.default'
  value 'simple'
end
