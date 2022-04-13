require "json"

activate :sprockets
set :css_dir, 'stylesheets'
set :images_dir, 'images'

configure :build do
  activate :minify_css
end

DEFAULT_GEMS_FILE = File.read("default_gems.json")
DEFAULT_GEMS_JSON = JSON.parse(DEFAULT_GEMS_FILE)["gems"]
BUNDLED_GEMS_FILE = File.read("bundled_gems.json")
BUNDLED_GEMS_JSON = JSON.parse(BUNDLED_GEMS_FILE)["gems"]
LIBRARIES_FILE = File.read("libraries.json")
LIBRARIES_JSON = JSON.parse(LIBRARIES_FILE)["gems"]
CRUBY_SOURCE_PREFIX = "https://github.com/ruby/ruby/tree/master/"
JRUBY_SOURCE_PREFIX = "https://github.com/jruby/jruby/tree/master/"

STDGEMS_VERSION = JSON.parse(DEFAULT_GEMS_FILE)["version"]

CURRENT_RUBY_VERSION = '3.1.2'

RUBY_3_1_VERSIONS = %w[
  3.1.2
  3.1.1
  3.1.0
]

RUBY_3_0_VERSIONS = %w[
  3.0.4
  3.0.3
  3.0.2
  3.0.1
  3.0.0
]

RUBY_2_7_VERSIONS = %w[
  2.7.6
  2.7.5
  2.7.4
  2.7.3
  2.7.2
  2.7.1
  2.7.0
]

RUBY_2_6_VERSIONS = %w[
  2.6.10
  2.6.9
  2.6.8
  2.6.7
  2.6.6
  2.6.5
  2.6.4
  2.6.3
  2.6.2
  2.6.1
  2.6.0
]

RUBY_2_5_VERSIONS = %w[
  2.5.9
  2.5.8
  2.5.7
  2.5.6
  2.5.5
  2.5.4
  2.5.3
  2.5.2
  2.5.1
  2.5.0
]

RUBY_2_4_VERSIONS = %w[
  2.4.10
  2.4.9
  2.4.8
  2.4.7
  2.4.6
  2.4.5
  2.4.4
  2.4.3
  2.4.2
  2.4.1
  2.4.0
]

RUBY_2_3_VERSIONS = %w[
  2.3.8
  2.3.7
  2.3.6
  2.3.5
  2.3.4
  2.3.3
  2.3.2
  2.3.1
  2.3.0
]

RUBY_2_2_VERSIONS = %w[
  2.2.10
  2.2.9
  2.2.8
  2.2.7
  2.2.6
  2.2.5
  2.2.4
  2.2.3
  2.2.2
  2.2.1
  2.2.0
]

LISTED_RUBY_VERSIONS = \
  RUBY_3_1_VERSIONS +
  RUBY_3_0_VERSIONS +
  RUBY_2_7_VERSIONS +
  RUBY_2_6_VERSIONS +
  RUBY_2_5_VERSIONS +
  RUBY_2_4_VERSIONS +
  RUBY_2_3_VERSIONS +
  RUBY_2_2_VERSIONS

MATRIX_RUBY_VERSIONS = %w[3.1 3.0 2.7 2.6 2.5 2.4 2.3 2.2]
MATRIX_SUPPORTED_RUBY_VERSIONS = \
  RUBY_3_1_VERSIONS[0,3] +
  RUBY_3_0_VERSIONS[0,3] +
  RUBY_2_7_VERSIONS[0,3]
MATRIX_ALL_VERSIONS = LISTED_RUBY_VERSIONS

STATS = {
  total_count: DEFAULT_GEMS_JSON.size + BUNDLED_GEMS_JSON.size + LIBRARIES_JSON.size,
  gemified_count: DEFAULT_GEMS_JSON.size + BUNDLED_GEMS_JSON.size,
  gemified_percentage: (DEFAULT_GEMS_JSON.size + BUNDLED_GEMS_JSON.size).to_f / (DEFAULT_GEMS_JSON.size + BUNDLED_GEMS_JSON.size + LIBRARIES_JSON.size),
}

def grouped_ruby_versions
  LISTED_RUBY_VERSIONS.group_by{ |ruby_version| ruby_version.to_f }
end

def build_gem_pages_for!(source, gem_type)
  source.each do |gem_info|
    proxy "/#{ gem_info["gem"] }/index.html", "/gem.html", :locals => { :gem_info => gem_info, gem_type: gem_type }, ignore: true
  end
end

def build_library_pages_for!(source)
  source.each do |gem_info|
    proxy "/#{ gem_info["gem"] }/index.html", "/library.html", :locals => { :gem_info => gem_info, gem_type: "library" }, ignore: true
  end
end

def build_version_pages!
  LISTED_RUBY_VERSIONS.each do |ruby_version|
    proxy "/#{ ruby_version }/index.html", "/version.html", :locals => { :ruby_version => ruby_version }, ignore: true
  end
end

def build_version_redirects!
  grouped_ruby_versions.each do |major_version, minor_versions|
    redirect "#{major_version}/index.html", to: "/#{minor_versions.max}"
  end
end

def hybrid_default_gems_json
  DEFAULT_GEMS_JSON.select{ |default_gem|
    BUNDLED_GEMS_JSON.map{ |bundled_gem| bundled_gem["gem"] }.include?(default_gem["gem"]) &&
    !default_gem["removed"]
  }.map{ |default_gem|
    {
      "gem" => default_gem["gem"],
      "default" => default_gem,
      "bundled" => BUNDLED_GEMS_JSON.find{ |bundled_gem| bundled_gem["gem"] == default_gem["gem"] }
    }
  }
end

def hybrid_bundled_gems_json
  BUNDLED_GEMS_JSON.select{ |bundled_gem|
    DEFAULT_GEMS_JSON.map{ |default_gem| default_gem["gem"] }.include?(bundled_gem["gem"]) &&
    !bundled_gem["removed"]
  }.map{ |bundled_gem|
    {
      "gem" => bundled_gem["gem"],
      "bundled" => bundled_gem,
      "default" => DEFAULT_GEMS_JSON.find{ |default_gem| default_gem["gem"] == bundled_gem["gem"] }
    }
  }
end

def build_all_pages!
  build_library_pages_for! LIBRARIES_JSON
  build_gem_pages_for! DEFAULT_GEMS_JSON, "default"
  build_gem_pages_for! BUNDLED_GEMS_JSON, "bundled"
  build_gem_pages_for! hybrid_default_gems_json, "hybrid_default"
  build_gem_pages_for! hybrid_bundled_gems_json, "hybrid_bundled"
  build_version_pages!
  build_version_redirects!
end

build_all_pages!

helpers do
  def ruby_prev_version(ruby_version)
    return "-" if ruby_version === "2.2.0"
    LISTED_RUBY_VERSIONS[LISTED_RUBY_VERSIONS.find_index(ruby_version) + 1]
  end

  def current_ruby_version
    CURRENT_RUBY_VERSION
  end

  def listed_ruby_versions
    LISTED_RUBY_VERSIONS
  end

  def build_resource_list(gem_info, short = false)
    res = []

    if gem_info["rubygemsLink"]
      res << "[RubyGems](#{gem_info["rubygemsLink"]})"
    end

    if gem_info["sourceRepository"]
      res << "[GitHub](#{gem_info["sourceRepository"]})"
    end

    case gem_info["rdocLink"]
    when Array
      gem_info["rdocLink"].each_with_index{ |rdocLink, index|
        res << "[RDoc (#{index + 1})](#{rdocLink})"
      }
    when String
      res << "[RDoc](#{gem_info["rdocLink"]})"
    end

    if !gem_info["removed"] && !short
      case gem_info["mriSourcePath"]
      when Array
        gem_info["mriSourcePath"].each_with_index{ |mriSourcePath, index|
          res << "[CRuby (#{index + 1})](#{CRUBY_SOURCE_PREFIX + mriSourcePath})"
        }
      when String
        res << "[CRuby](#{CRUBY_SOURCE_PREFIX + gem_info["mriSourcePath"]})"
      end

      case gem_info["jrubySourcePath"]
      when String
        res << "[JRuby](#{CRUBY_SOURCE_PREFIX + gem_info["jrubySourcePath"]})"
      when true
        # nothing
      when Array
        gem_info["jrubySourcePath"].reject{|jsp| jsp == true }.each_with_index{ |jrubySourcePath, index|
          res << "[JRuby (#{index + 1})](#{CRUBY_SOURCE_PREFIX + jrubySourcePath})"
        }
      end
    end

    res.join(" · ")
  end

  def gem_list_for(source, exact_ruby_version, exact_prev_version)
    major_ruby_version = exact_ruby_version.to_f.to_s
    major_prev_version = exact_prev_version.to_f.to_s

    source.select{ |gem_info|
      gem_info["versions"][exact_ruby_version] ||
      gem_info["versions"][major_ruby_version]
    }.map{ |gem_info|
      gem_info_row(gem_info, major_ruby_version, exact_ruby_version, major_prev_version, exact_prev_version)
    }.join("\n")
  end

  def new_gems_in(source, ruby_version)
    major_ruby_version = ruby_version.to_f.to_s

    source.select{ |gem_info|
      gem_info["versions"].keys.min.to_f.to_s === major_ruby_version
    }.map{ |gem_info|
      gem_info_row(gem_info)
    }.join("\n")
  end

  def previous_major_ruby_version(major_ruby_version)
    return "2.7" if major_ruby_version.to_f == 3.0
    "%.1f" % (major_ruby_version.to_f - 0.1)
  end

  def removed_gems_in(source, ruby_version)
    ruby_version = previous_major_ruby_version(ruby_version.to_f.to_s)

    source.select{ |gem_info|
      gem_info["versions"].keys.max.to_f.to_s === ruby_version
    }.map{ |gem_info|
      gem_info_row(gem_info)
    }.join("\n")
  end

  def gem_info_row(gem_info, major_ruby_version = nil, exact_ruby_version = nil, major_prev_version = nil, exact_prev_version = nil)
    [
      "[#{ gem_info["gem"] }](/#{ gem_info["gem"] })" +
          (gem_info["native"] ? ' **c**' : ''),
      exact_ruby_version && gem_info["versions"][exact_ruby_version] ||
      major_ruby_version && gem_info["versions"][major_ruby_version],
      exact_prev_version && gem_info["versions"][exact_prev_version] ||
      major_prev_version && gem_info["versions"][major_prev_version] ||
      (major_ruby_version ? "-" : nil),
      gem_info["description"],
      build_resource_list(gem_info)
    ].compact.join(" | ")
  end

  def version_matrix_for(source, ruby_versions, label)
    (
      [
        [label] + ruby_versions,
        ["--"] * (ruby_versions.size + 1),
      ] + source.map{ |gem_info|
        [
          "[#{ gem_info["gem"] }](/#{ gem_info["gem"] })" +
              (gem_info["native"] ? ' **c**' : ''),
          *ruby_versions.map{ |ruby_version|
            exact_ruby_version = ruby_version
            major_ruby_version = ruby_version.to_f.to_s

            gem_info["versions"][exact_ruby_version] ||
            gem_info["versions"][major_ruby_version] ||
            "-"
          }
        ]
      }.reject{ |versions|
        versions[1..-1].uniq == ["-"]
      }
    ).map{ |line| line.join(" | ") }.join("\n")
  end

  def default_gems_list(ruby_version = CURRENT_RUBY_VERSION)
    gem_list_for(DEFAULT_GEMS_JSON, ruby_version, ruby_prev_version(ruby_version))
  end

  def bundled_gems_list(ruby_version = CURRENT_RUBY_VERSION)
    gem_list_for(BUNDLED_GEMS_JSON, ruby_version, ruby_prev_version(ruby_version))
  end

  def libraries_list
    LIBRARIES_JSON.map{ |gem_info|
      [
        "[#{ gem_info["gem"] }](/#{ gem_info["gem"] })" +
            (gem_info["native"] ? ' **c**' : ''),
        gem_info["description"],
        build_resource_list(gem_info)
      ].join(" | ")
    }.join("\n")
  end

  def default_gems_version_matrix
    version_matrix_for(DEFAULT_GEMS_JSON, MATRIX_RUBY_VERSIONS, "Default Gem")
  end

  def bundled_gems_version_matrix
    version_matrix_for(BUNDLED_GEMS_JSON, MATRIX_RUBY_VERSIONS, "Bundled Gem")
  end

  def default_gems_supported_version_matrix
    version_matrix_for(DEFAULT_GEMS_JSON, MATRIX_SUPPORTED_RUBY_VERSIONS, "Default Gem")
  end

  def bundled_gems_supported_version_matrix
    version_matrix_for(BUNDLED_GEMS_JSON, MATRIX_SUPPORTED_RUBY_VERSIONS, "Bundled Gem")
  end

  def default_gems_all_matrix
    version_matrix_for(DEFAULT_GEMS_JSON, MATRIX_ALL_VERSIONS, "Default Gem")
  end

  def bundled_gems_all_matrix
    version_matrix_for(BUNDLED_GEMS_JSON, MATRIX_ALL_VERSIONS, "Bundled Gem")
  end

  def default_gems_version_matrix_3_1
    version_matrix_for(DEFAULT_GEMS_JSON, RUBY_3_1_VERSIONS, "Default Gem")
  end

  def bundled_gems_version_matrix_3_1
    version_matrix_for(BUNDLED_GEMS_JSON, RUBY_3_1_VERSIONS, "Bundled Gem")
  end

  def default_gems_version_matrix_3_0
    version_matrix_for(DEFAULT_GEMS_JSON, RUBY_3_0_VERSIONS, "Default Gem")
  end

  def bundled_gems_version_matrix_3_0
    version_matrix_for(BUNDLED_GEMS_JSON, RUBY_3_0_VERSIONS, "Bundled Gem")
  end

  def default_gems_version_matrix_2_7
    version_matrix_for(DEFAULT_GEMS_JSON, RUBY_2_7_VERSIONS, "Default Gem")
  end

  def bundled_gems_version_matrix_2_7
    version_matrix_for(BUNDLED_GEMS_JSON, RUBY_2_7_VERSIONS, "Bundled Gem")
  end

  def default_gems_version_matrix_2_6
    version_matrix_for(DEFAULT_GEMS_JSON, RUBY_2_6_VERSIONS, "Default Gem")
  end

  def bundled_gems_version_matrix_2_6
    version_matrix_for(BUNDLED_GEMS_JSON, RUBY_2_6_VERSIONS, "Bundled Gem")
  end

  def default_gems_version_matrix_2_5
    version_matrix_for(DEFAULT_GEMS_JSON, RUBY_2_5_VERSIONS, "Default Gem")
  end

  def bundled_gems_version_matrix_2_5
    version_matrix_for(BUNDLED_GEMS_JSON, RUBY_2_5_VERSIONS, "Bundled Gem")
  end

  def default_gems_version_matrix_2_4
    version_matrix_for(DEFAULT_GEMS_JSON, RUBY_2_4_VERSIONS, "Default Gem")
  end

  def bundled_gems_version_matrix_2_4
    version_matrix_for(BUNDLED_GEMS_JSON, RUBY_2_4_VERSIONS, "Bundled Gem")
  end

  def default_gems_version_matrix_2_3
    version_matrix_for(DEFAULT_GEMS_JSON, RUBY_2_3_VERSIONS, "Default Gem")
  end

  def bundled_gems_version_matrix_2_3
    version_matrix_for(BUNDLED_GEMS_JSON, RUBY_2_3_VERSIONS, "Bundled Gem")
  end

  def default_gems_version_matrix_2_2
    version_matrix_for(DEFAULT_GEMS_JSON, RUBY_2_2_VERSIONS, "Default Gem")
  end

  def bundled_gems_version_matrix_2_2
    version_matrix_for(BUNDLED_GEMS_JSON, RUBY_2_2_VERSIONS, "Bundled Gem")
  end

  def new_default_gems_in(ruby_version)
    new_gems_in(DEFAULT_GEMS_JSON, ruby_version)
  end

  def new_bundled_gems_in(ruby_version)
    new_gems_in(BUNDLED_GEMS_JSON, ruby_version)
  end

  def removed_default_gems_in(ruby_version)
    removed_gems_in(DEFAULT_GEMS_JSON, ruby_version)
  end

  def removed_bundled_gems_in(ruby_version)
    removed_gems_in(BUNDLED_GEMS_JSON, ruby_version)
  end

  def unmaintained_default_gems
    DEFAULT_GEMS_JSON.select{ |gem_info|
      !gem_info["maintainer"] && !gem_info["removed"]
    }.map{ |gem_info|
      [
        "[#{ gem_info["gem"] }](/#{ gem_info["gem"] })" +
            (gem_info["native"] ? ' **c**' : ''),
        gem_info["description"],
        build_resource_list(gem_info)
      ].compact.join(" | ")
    }.join("\n")
  end

  def removed_default_gems
    DEFAULT_GEMS_JSON.select{ |gem_info|
      gem_info["removed"] && BUNDLED_GEMS_JSON.none?{ |bundled_gem| bundled_gem["gem"] == gem_info["gem"] }
    }.map{ |gem_info|
      [
        "[#{ gem_info["gem"] }](/#{ gem_info["gem"] })" +
            (gem_info["native"] ? ' **c**' : ''),
        gem_info["description"],
        build_resource_list(gem_info)
      ].compact.join(" | ")
    }.join("\n")
  end

  def removed_bundled_gems
    BUNDLED_GEMS_JSON.select{ |gem_info|
      gem_info["removed"] && DEFAULT_GEMS_JSON.none?{ |default_gem| default_gem["gem"] == gem_info["gem"] }
    }.map{ |gem_info|
      [
        "[#{ gem_info["gem"] }](/#{ gem_info["gem"] })" +
            (gem_info["native"] ? ' **c**' : ''),
        gem_info["description"],
        build_resource_list(gem_info)
      ].compact.join(" | ")
    }.join("\n")
  end

  def default_gems_json
    DEFAULT_GEMS_FILE
  end

  def bundled_gems_json
    BUNDLED_GEMS_FILE
  end

  def libraries_json
    LIBRARIES_FILE
  end

  def stats
    STATS
  end

  def gem_description(gem_info, gem_type)
    gem_info = gem_info["default"] if gem_type == "hybrid_default"
    gem_info = gem_info["bundled"] if gem_type == "hybrid_bundled"
    gem_info["description"] + "\n\n" + build_resource_list(gem_info, :short)
  end

  def gem_details_properties(gem_info, gem_type)
    gem_info = gem_info["default"] if gem_type == "hybrid_default"
    gem_info = gem_info["bundled"] if gem_type == "hybrid_bundled"
    res = []
    verb = "is"

    if gem_info["removed"]
      res << ["This standard library has been removed from Ruby and is **no longer available**"]
      verb = "was"
    end

    if gem_type == "hybrid_default"
      res << ["This standard library #{verb} a **default gem**, but was a bundled one before"]
    elsif gem_type == "hybrid_bundled"
      res << ["This standard library #{verb} a **bundled gem**, but was a default one before"]
    elsif gem_type == "bundled"
      res << ["This standard library #{verb} a **bundled gem**"]
    elsif gem_type == "default"
      res << ["This standard library #{verb} a **default gem**"]
    else
      res << ["This standard library #{verb} a **default library**, which is not versioned on its own"]
    end

    if !gem_info["rubygemsLink"]
      res << ["The library #{verb} not published on RubyGems"]
    end

    unless gem_info["removed"]
      if gem_type == "bundled" || gem_type == "hybrid_bundled"
        res << ["To use with bundler, add this to your Gemfile: `gem \"#{ gem_info["gem"] }\"`"]
      end

      if gem_info["autoRequire"]
        res << ["The library **is required automatically**"]
      elsif !gem_info["removed"]
        res << ["Use `require \"#{require_path_of(gem_info)}\"` to load this library"]
      end

      if gem_info["native"]
        res << ["The library **contains native extensions**"]
      else
        res << ["The library is written in Ruby, there are **no native extensions**"]
      end

      if gem_info["maintainer"]
        res << ["Current maintainer#{ gem_info["maintainer"].is_a?(Array) && gem_info["maintainer"].size > 1 ? 's' : '' }: " + Array(gem_info["maintainer"]).join(", ")]
      elsif gem_type != "bundled" && gem_type != "hybrid_bundled" && !gem_info["removed"]
        res << ["This library **has no designated maintainer**"]
      end
    end

    if gem_info["alternatives"]
      combined_alternatives = gem_info["alternatives"].map{ |alt_desc, alt_link|
        if alt_link
          "[#{alt_desc}](#{alt_link})"
        else
          alt_desc
        end
      }.join(", ")

      res << ["Similar gems and alternatives: #{combined_alternatives}"]
    end

    res.map{ |line|
      if line[1]
        "- [#{ line[0] }](/#{ line[1] })"
      else
        "- #{ line[0] }"
      end
    }.join("\n")
  end

  def gem_sources(gem_info, gem_type)
    gem_info = gem_info["default"] if gem_type == "hybrid_default"
    gem_info = gem_info["bundled"] if gem_type == "hybrid_bundled"

    res = "Source | Location\n" \
          "-------|---------\n"

    if gem_info["sourceRepository"]
      res += "Gem Repository | [#{ gem_info["sourceRepository"].gsub(/^https?:\/\//, "") }](#{ gem_info["sourceRepository"] })\n"
    end

    if !gem_info["removed"]
      if gem_info["mriSourcePath"]
        res += "CRuby | "

        case gem_info["mriSourcePath"]
        when Array
          res +=  gem_info["mriSourcePath"].map{ |mriSourcePath|
            "[#{mriSourcePath}](#{CRUBY_SOURCE_PREFIX}#{mriSourcePath})"
          }.join("<br>") + "\n"
        when String
          res += "[#{gem_info["mriSourcePath"]}](#{CRUBY_SOURCE_PREFIX}#{gem_info["mriSourcePath"]})\n"
        end
      end

      if gem_info["jrubySourcePath"] || gem_info["jrubySourcePath"] == false
        res += "JRuby | "

        case gem_info["jrubySourcePath"]
        when String
          res += "[#{gem_info["jrubySourcePath"]}](#{JRUBY_SOURCE_PREFIX}#{gem_info["jrubySourcePath"]})\n"
        when true
          res += "from RubyGems\n"
        when false
          res += "not included\n"
        when Array
          res += gem_info["jrubySourcePath"].map{ |jrubySourcePath|
            if jrubySourcePath == true
              "from RubyGems with patches"
            else
              "[#{jrubySourcePath}](#{JRUBY_SOURCE_PREFIX}#{jrubySourcePath})"
            end
          }.join("<br>") + "\n"
        end
      end
    end

    res + "{:.small-table .table-witdh-15-15}"
  end


  def gem_notes(gem_info, gem_type)
    gem_info = gem_info["default"] if gem_type == "hybrid_default"
    gem_info = gem_info["bundled"] if gem_type == "hybrid_bundled"

    gem_info["notes"]
  end

  def gem_details_versions_list(gem_info)
    "\n| #{ gem_info["gem"] } | Ruby |\n" \
    "|----------------------|------|\n" +
    LISTED_RUBY_VERSIONS.map{ |ruby_version|
      exact_ruby_version = ruby_version
      major_ruby_version = ruby_version.to_f.to_s

      [
        ruby_version,
        gem_info["versions"][exact_ruby_version] ||
        gem_info["versions"][major_ruby_version]
      ]
    }.select{ |_, gem_version|
      gem_version
    }.group_by{ |_, gem_version|
      gem_version
    }.map{ |gem_version, ruby_versions_with_gem_version|
      if ruby_versions_with_gem_version.size > 1
        ruby_versions_range = ruby_versions_with_gem_version[-1][0] + " .. " + ruby_versions_with_gem_version[0][0]
      else
        ruby_versions_range = ruby_versions_with_gem_version[0][0]
      end

      if !gem_info["sourceRepository"]
        linked_gem_version = gem_version
      elsif gem_version =~ /(?<triple_version>[^\.](?:\..+?){2})\.(?<patch_level>.+)/
        linked_gem_version = "<a href=\"#{ gem_info["sourceRepository"] }/tree/v#{ $~[:triple_version] }\">#{ $~[:triple_version] }</a>.**#{ $~[:patch_level] }**"
      else
        linked_gem_version = "<a href=\"#{ gem_info["sourceRepository"] }/tree/v#{ gem_version }\">#{ gem_version }</a>"
      end

      "| #{ linked_gem_version } | #{ ruby_versions_range } |"
    }.join("\n") +
    "\n{:.small-table .table-witdh-15-15}"
  end

  def gem_details_versions(gem_info, gem_type = nil)
    if gem_type == "hybrid_default"
      "### As Default Gem\n" +
      gem_details_versions_list(gem_info["default"]) + "\n\n" +
      "### As Bundled Gem\n" +
      gem_details_versions_list(gem_info["bundled"])
    elsif gem_type == "hybrid_bundled"
      "### As Bundled Gem\n" +
      gem_details_versions_list(gem_info["bundled"]) + "\n\n" +
      "### As Default Gem\n" +
      gem_details_versions_list(gem_info["default"])
    else
      gem_details_versions_list(gem_info)
    end
  end

  def require_path_of(gem_info)
    gem_info["gem"].tr "-", "/"
  end

  def dev_version_warning(ruby_version)
    if ruby_version > CURRENT_RUBY_VERSION
      "**Warning:** This Ruby version has not been released, yet. Standard gem data might still change."
    end
  end

  def heading(current_page, gem_info = nil, gem_type = nil, ruby_version = nil)
    current_page.data.heading ||
    gem_info && "#{ gem_info["gem"] } #{gem_type === 'library' ? 'Library' : 'Gem'}" ||
    ruby_version && "Standard Gems #{ruby_version}" ||
    "Ruby Standard Gems"
  end

  def title(current_page, gem_info = nil, ruby_version = nil)
    if current_page.data.title
      "Standard Gems: #{current_page.data.title}"
    elsif gem_info
      "Standard Gems: #{ gem_info["gem"] }"
    elsif ruby_version
      "Standard Gems #{ ruby_version }"
    else
      "Standard Gems"
    end
  end

  def stdgems_version
    STDGEMS_VERSION
  end
end
