desc "Generate stdgems.json from other JSON files"
task :stdgems_json do
  require "json"

  default_gems_file = File.read("default_gems.json")
  default_gems = JSON.parse(default_gems_file)["gems"]
  bundled_gems_file = File.read("bundled_gems.json")
  bundled_gems = JSON.parse(bundled_gems_file)["gems"]
  libraries_file = File.read("libraries.json")
  libraries = JSON.parse(libraries_file)["gems"]
  stdgems_file_template = File.read("_stdgems.json")
  stdgems_file = JSON.parse(stdgems_file_template)
  stdgems = {}
  stdgems_out_filename = "stdgems.json"

  libraries.each{ |library|
    gem_name = library["gem"]

    # copy over data, add type to json
    stdgems[gem_name] = {
      "gem" => gem_name,
      "currentType" => "library",
      **library
    }
  }

  bundled_gems.each{ |bundled_gem|
    gem_name = bundled_gem["gem"]

    # add prevType only if it was default gem before
    was_default_gem = !bundled_gem["removed"] && default_gems.map{ |default_gem| default_gem["gem"] }.include?(gem_name)

    # copy over data, add type to json
    stdgems[gem_name] = {
      "gem" => gem_name,
      "currentType" => "bundled",
      **(was_default_gem ? { "prevType" => "default"} : {}),
      **bundled_gem
    }

    # always nest versions in category
    stdgems[gem_name]["versions"] = { "bundled" => bundled_gem["versions"] }
  }

  default_gems.each{ |default_gem|
    gem_name = default_gem["gem"]

    if !stdgems[gem_name]
      # copy over data if no bundled gem of this name exists
      stdgems[gem_name] = {
        "gem" => gem_name,
        "currentType" => "default",
        **default_gem
      }

      # always nest versions in category
      stdgems[gem_name]["versions"] = { "default" => default_gem["versions"] }
    else
      # or merge data
      bundled_gem = stdgems[gem_name]
      is_now_bundled = bundled_gem["prevType"] == "default"
      is_now_default = bundled_gem["prevType"] == nil

      bundled_gem.delete("currentType")
      bundled_gem.delete("prevType")
      bundled_gem.delete("removed")

      bundled_gem_versions = bundled_gem["versions"]["bundled"]
      default_gem_versions = default_gem["versions"]

      stdgems[gem_name] = {
        "gem" => gem_name,
        "currentType" => is_now_default ? "default" : "bundled",
        "prevType" => is_now_default ? "bundled" : "default",
        **(is_now_default ? default_gem : bundled_gem),
        "versions" => {
          "default" => default_gem_versions,
          "bundled" => bundled_gem_versions,
        }
      }
    end
  }

  stdgems_file["gems"] = stdgems.to_a.sort.map(&:last)
  File.write(stdgems_out_filename, JSON.pretty_generate(stdgems_file))
  puts "Done"
end

### WEBSITE ###

require 'middleman-gh-pages'

desc 'Deploy to stdgems.org'
# task :deploy => :publish do
task :deploy do
  sh 'git checkout website && rm -rf ./build && rake publish && git checkout gh-pages && git pull origin gh-pages && git push production gh-pages:production && git checkout website'
end
