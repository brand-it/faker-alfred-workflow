require File.expand_path('./gem_installer', __dir__).to_s
extend GemInstaller
install 'faker'
require 'faker'
