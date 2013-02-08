require "katameru"
require "thor"
require "fpm"
require "fpm/command"
require "grit"

class Katameru::CLI < Thor
  include Thor::Actions
  class_option :name,    :aliases => '-n', :type => :string, :default => File.basename(Dir.pwd),               :desc => "name of package"
  class_option :prefix,  :aliases => '-p', :type => :string, :default => '/usr/local/'+File.basename(Dir.pwd), :desc => "root directory for install"
  class_option :version, :aliases => '-v', :type => :string,                                                   :desc => "version of package (git tag automatically)"
  class_option :ref,                       :type => :string, :default => 'master',                             :desc => "target ref of git"
  class_option :work_dir,                  :type => :string, :default => './.katameru',                        :desc => "temporary directory"

  desc "bundle", "Bundle required modules"
  def bundle
    archive
    install_modules
  end

  desc "fpm", "Pack current directory to a package"
  def fpm
    command = "fpm -s dir -t deb -n #{options[:name]} -v #{options[:version]} -p #{options[:name]}-VERSION_ARCH.deb -C #{tmp_dir} #{prefix}"
    p command
    system(command)
  end

  desc "version", "Display Katameru gem version"
  map ["-v", "--version"] => :version
  def version
    puts Katameru::VERSION
  end

  private

  def repo
    @repo = Grit::Repo.new('.') if @repo.nil?
    @repo
  end

  def ref
    repo.commits(options[:ref]).first
  end

  def prefix
    path = options[:prefix].split('/')
    path.shift
    path.join('/') + '/'
  end

  def archive
    repo.git.archive({:format => 'tar', :prefix => prefix}, options[:ref], "| tar -x -C #{tmp_dir}")
  end

  def install_modules
    command = "env; cd #{tmp_dir}/#{prefix}; bundle install --path=vendor/bundle"
    env = ENV
    ENV.clear
    path = `. /etc/profile && echo $PATH`.chomp
    ENV["PATH"] = path
    ENV["HOME"] = env["HOME"]
    system "bash -l -c '#{command}'"
    env.each do |k,v|
      ENV[k] = v
    end
  end

  def tmp_dir
    work_dir = File.expand_path(options[:work_dir])
    Dir.mkdir(work_dir) unless File.exists?(work_dir)
    dir = File.join(work_dir, package_version)
    Dir.mkdir(dir) unless File.exists?(dir)
    dir
  end

  def package_version
    if options[:version].nil?
      raise "TODO: create a latest version from git tag"
    else
      options[:version]
    end
  end
end
