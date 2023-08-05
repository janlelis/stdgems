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
      "current_type" => "library",
      **library
    }
  }

  bundled_gems.each{ |bundled_gem|
    gem_name = bundled_gem["gem"]

    # add prev_type only if it was default gem before
    was_default_gem = !bundled_gem["removed"] && default_gems.map{ |default_gem| default_gem["gem"] }.include?(gem_name)

    # copy over data, add type to json
    stdgems[gem_name] = {
      "gem" => gem_name,
      "current_type" => "bundled",
      **(was_default_gem ? { "prev_type" => "default"} : {}),
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
        "current_type" => "default",
        **default_gem
      }

      # always nest versions in category
      stdgems[gem_name]["versions"] = { "default" => default_gem["versions"] }
    else
      # or merge data
      bundled_gem = stdgems[gem_name]
      is_now_bundled = bundled_gem["prev_type"] == "default"
      is_now_default = bundled_gem["prev_type"] == nil

      bundled_gem.delete("current_type")
      bundled_gem.delete("prev_type")
      bundled_gem.delete("removed")

      bundled_gem_versions = bundled_gem["versions"]["bundled"]
      default_gem_versions = default_gem["versions"]

      stdgems[gem_name] = {
        "gem" => gem_name,
        "current_type" => is_now_default ? "default" : "bundled",
        "prev_type" => is_now_default ? "bundled" : "default",
        **(is_now_default ? default_gem : bundled_gem),
        "versions" => {
          "default" => default_gem_versions,
          "bundled" => bundled_gem_versions,
        }
      }
    end
  }

  stdgems_file["gems"] = stdgems.to_a.sort.to_h
  File.write(stdgems_out_filename, JSON.pretty_generate(stdgems_file))
  puts "Done"
end