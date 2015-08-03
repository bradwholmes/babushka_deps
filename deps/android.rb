dep 'android' do
#  requires 'android-sdk.bin'
  requires 'android-home environment variable'
end

dep 'android-sdk.bin' do
  provides 'android', 'adb', 'fastboot', 'uiautomatorviewer'
end

dep 'android-home environment variable' do 
  requires 'bashrc-android-home environment variable'

  met? {
    puts "stuff: " + shell("echo $ANDROID_HOME")
    !shell?("echo $ANDROID_HOME").empty?
  }

  meet {
    shell "source ~/.bashrc"
  }
end

dep 'bashrc-android-home environment variable' do
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
end
