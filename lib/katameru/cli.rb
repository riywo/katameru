require "katameru"
require "thor"
require "fpm"
require "fpm/command"

class Katameru::CLI < Thor
  desc "bundle", "Bundle required modules"
  def bundle
  end
end
