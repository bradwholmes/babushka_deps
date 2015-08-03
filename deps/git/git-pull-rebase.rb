dep 'git-pull-rebase', :template => 'git_config' do
  property "branch.autosetuprebase"
  value "always"
end
