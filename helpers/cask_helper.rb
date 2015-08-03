class CaskHelper < Babushka::BrewHelper
  class << self
    def pkg_cmd; 'brew cask' end
    def manager_dep; 'homebrew-cask' end
    def pkg_type; :cask end
    def manager_key; :cask end

    def present?
      Babushka::BrewHelper.has? cask_package_name
    end

    def prefix
      Babushka::BrewHelper.prefix
    end

    def cask_package_name
      'brew-cask'
    end

    def all_versions_of pkg
      pkg_name = pkg.respond_to?(:name) ? pkg.name : pkg
      Dir[
        installed_pkgs_path / pkg_name / '*'
      ].map {|i|
        File.basename i.chomp('/')
      }.map(&:to_s)
    end

    def cask_prefix
      Babushka::BrewHelper.brew_path_for cask_package_name
    end

    def caskroom
      "/opt/homebrew-cask/Caskroom".p
    end

    private
      def has_pkg? pkg
        all_versions_of(pkg).any?
      end

      def pkg_update_command
        "brew update"
      end

      def cmdline_spec_for pkg
        pkg.name
      end

      def existing_formulas
        formulas_paths.map {|path|
          Dir[path / '*.rb'].map {|i| File.basename i, '.rb' }
        }.flatten.uniq
      end

      def installed_pkgs_path
        caskroom
      end

      def taps_path
        prefix.p / 'Library' / 'Taps'
      end

      def formulas_paths
        [
          cask_prefix / 'Casks',
          Dir[taps_path / '*' / 'Casks'].map(&:p),
        ].flatten
      end
  end
end

Babushka::PkgHelper.all_manager_keys << CaskHelper.manager_key
