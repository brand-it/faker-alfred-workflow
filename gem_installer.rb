require 'fileutils'
require 'rubygems'
require 'rubygems/gem_runner'
require 'rubygems/exceptions'
require File.expand_path('./logger', __dir__).to_s

ENV['GEM_HOME'] = File.expand_path('gems', __dir__).to_s
FileUtils.mkdir_p(ENV['GEM_HOME'])
ENV['GEM_PATH'] = "#{ENV['GEM_HOME']}:/var/lib/ruby/gems/1.8"
Gem.clear_paths

module GemInstaller
  def install(lib)
    return false if `gem list #{lib}`.include?(lib)
    Logger.info("running 'install #{lib} --no-ri --no-rdoc'")
    Gem::GemRunner.new.run(['install', lib, '--no-ri', '--no-rdoc'])
    Logger.info("failed to 'install #{lib} --no-ri --no-rdoc'")
    false
  rescue Gem::SystemExitException
    Logger.info("Successfully Installed #{lib}")
    true
  end

  def reinstall(lib)
    return install(lib) unless `gem list #{lib}`.include?(lib)
    Logger.info("Uninstalling #{lib}")
    Gem::GemRunner.new.run(['uninstall', lib, '-a'])
    Logger.info("Failed to uninstall #{lib}")
    install(lib)
  rescue StandardError => exception
    Logger.error("Failure #{exception.message}")
  end
end
