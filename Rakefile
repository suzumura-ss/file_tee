#
#   Copyright 2010 Toshiyuki Suzumura.
#
#   This file is part of file_tee.
#
#   This is free software: you can redistribute it and/or modify
#   it under the terms of the GNU Lesser General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This software is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU Lesser General Public License for more details.
#
#   You should have received a copy of the GNU Lesser General Public License
#   along with Castoro.  If not, see <http://www.gnu.org/licenses/>.
#

require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'

spec = Gem::Specification.new do |s|
  s.name = 'file_tee'
  s.version = '0.0.2'
  s.has_rdoc = false
  s.extra_rdoc_files = ['README']
  s.summary = "This is file access utility like 'tee'."
  s.description = s.summary
  s.author = "Toshiyuki Suzumura"
  s.email = "Twitter: @suzumura_ss"
  s.homepage = "http://d.hatena.ne.jp/suzumura_ss/"
  s.files = %w(History LICENSE README COPYING.LESSER Rakefile) + Dir.glob("{lib,spec}/**/*")
  s.require_path = "lib"
  #s.executables = Dir.glob("bin/**/*").map { |f| File.basename(f) }
  #s.bindir = "bin"
  #s.extensions = ["ext/extconf.rb"]
  #s.add_dependency('gem_name', '>=require_version')
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end

Rake::RDocTask.new do |rdoc|
  files =['README', 'LICENSE', 'lib/**/*.rb']
  rdoc.rdoc_files.add(files)
  rdoc.main = "README" # page to start on
  rdoc.title = "castoro-gateway Docs"
  rdoc.rdoc_dir = 'doc/rdoc' # rdoc output folder
  rdoc.options << '--line-numbers'
end

desc 'Run tests for rspec tests'
task :spec do
  Dir.glob('spec/*_spec.rb').each {|t|
    puts "=== spec testing: #{t}"
    return false unless system("spec -c #{t}")
  }
end
