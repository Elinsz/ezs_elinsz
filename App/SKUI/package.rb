#!/usr/bin/env ruby

require "fileutils"
require "pathname"

begin
  require "zip" # `gem install rubyzip` - https://github.com/rubyzip/rubyzip
rescue LoadError
  Gem.install("rubyzip")
  require "zip"
end


### Configure Paths ############################################################

project_path = File.expand_path(File.join(__dir__, '..'))

source_basename = 'TT_Lib2'
source_root_rb = "#{source_basename}.rb"
source_path = File.join(project_path, source_basename)
source_pathname = Pathname.new(project_path)
source_files_pattern = File.join(source_path, "**", "**")

archive_path = File.join(project_path, "archive")
FileUtils.mkdir_p(archive_path)


### Configure Files ############################################################

extension_name = "TT_Lib"
puts "Extension Name: #{extension_name}"

extension_root_rb = File.join(project_path, source_root_rb)
content = File.read(extension_root_rb)
version = content.match(/PLUGIN_VERSION\s*=\s*'([^']+)'/)[1]
puts "Version: #{version}"


build_version = version
build_date = Time.now.strftime("%d-%m-%Y")

archive_name = "#{extension_name}_#{build_version}_#{build_date}"
archive = File.join(archive_path, "#{archive_name}.rbz")


### Collect Files ##############################################################

build_files = Dir.glob(source_files_pattern)
build_files << extension_root_rb

libraries_exclude_pattern = /TT_Lib2\/libraries\/\d+\.\d+\.\d+\//
build_files.reject! { |file| file =~ libraries_exclude_pattern }


### Package ####################################################################

puts "Creating RBZ archive..."
puts "Destination: #{archive}"

if File.exist?(archive)
  puts "Archive already exist. Deleting existing archive."
  File.delete(archive)
end

Zip::File.open(archive, Zip::File::CREATE) do |zipfile|
  build_files.each { |file_item|
    next if File.directory?(file_item)
    pathname = Pathname.new(file_item)
    relative_name = pathname.relative_path_from(source_pathname)
    puts "Archiving: #{relative_name}"
    zipfile.add(relative_name, file_item)
  }
end

puts "Packing done!"
puts "#{archive}"
