meta :git_config do
  accepts_value_for :property
  accepts_value_for :value

  template {
    requires 'git'

    def config_format
        "#{property}=#{value}"
    end

    met? {
      shell!('git config --list').strip.lines.map(&:strip).include? config_format
    }

    meet {
      shell! "git config --global #{property} #{value}"
    }
  }
end
