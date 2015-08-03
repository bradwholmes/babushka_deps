dep 'android' do
  requires 'android-sdk.bin'
  requires 'android-home environment variable'
end

dep 'android-sdk.bin' do
  provides 'android', 'adb', 'fastboot'
end

dep 'android-home environment variable' do 
  android_home = '/usr/local/opt/android-sdk'
  bashrc = '~/.bashrc'
  export = "export ANDROID_HOME=#{android_home}"

  met? {
    bashrc.p.exists? && !bashrc.p.grep(export).empty?
  }

  meet {
    bashrc.p.touch
    bashrc.p.append(export + "\n")
  }

  after {
    log 'Restart shell to load $ANDROID_HOME'
  }
end
