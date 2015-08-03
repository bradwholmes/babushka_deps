dep 'homebrew-cask', :for => :osx, :template => 'lib' do
  requires 'homebrew tap'.with('phinze/cask')
  installs 'brew-cask'
end

dep 'homebrew tap', :tap_name, :for => :osx do
  requires 'homebrew'
  
  met? { shell!('brew tap').strip.lines.map(&:strip).include? tap_name.to_s }

  meet {
    log_block "Tapping '#{tap_name}'" do
      shell! 'brew', 'tap', tap_name.to_s
    end
  }
end
