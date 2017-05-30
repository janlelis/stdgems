require "json"

set :css_dir, 'stylesheets'
set :images_dir, 'images'

configure :build do
  activate :minify_css
end

DEFAULT_GEMS_FILE = File.read("default_gems.json")
DEFAULT_GEMS_JSON = JSON.parse(DEFAULT_GEMS_FILE)["gems"]
BUNDLED_GEMS_FILE = File.read("bundled_gems.json")
BUNDLED_GEMS_JSON = JSON.parse(BUNDLED_GEMS_FILE)["gems"]
MRI_SOURCE_PREFIX = "https://github.com/ruby/ruby/tree/trunk/"
CURRENT_RUBY_VERSION = "2.4.1"
LISTED_RUBY_VERSIONS = %w[
  2.5.0

  2.4.1
  2.4.0

  2.3.4
  2.3.3
  2.3.2
  2.3.1
  2.3.0

  2.2.7
  2.2.6
  2.2.5
  2.2.4
  2.2.3
  2.2.2
  2.2.1
  2.2.0
]

MATRIX_RUBY_VERSIONS = %w[2.5 2.4 2.3 2.2]
MATRIX_SUPPORTED_RUBY_VERSIONS = %w[
  2.4.1
  2.4.0

  2.3.4
  2.3.3
  2.3.2
  2.3.1
  2.3.0
]

def grouped_ruby_versions
  LISTED_RUBY_VERSIONS.group_by{ |ruby_version| ruby_version.to_f }
end

def build_gem_pages_for!(source, gem_type)
  source.each do |gem_info|
    proxy "/#{ gem_info["gem"] }/index.html", "/gem.html", :locals => { :gem_info => gem_info, gem_type: gem_type }, ignore: true
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

def build_all_pages!
  build_gem_pages_for! DEFAULT_GEMS_JSON, "default"
  build_gem_pages_for! BUNDLED_GEMS_JSON, "bundled"
  build_version_pages!
  build_version_redirects!
end

build_all_pages!

helpers do
  def current_ruby_version
    CURRENT_RUBY_VERSION
  end

  def listed_ruby_versions
    LISTED_RUBY_VERSIONS
  end

  def build_resource_list(gem_info)
    res = []

    if gem_info["rubygemsLink"]
      res << "[RubyGems](#{gem_info["rubygemsLink"]})"
    end

    if gem_info["sourceRepository"]
      res << "[GitHub](#{gem_info["sourceRepository"]})"
    end

    case gem_info["mriSourcePath"]
    when Array
      gem_info["mriSourcePath"].each_with_index{ |mriSourcePath, index|
        res << "[MRI (#{index + 1})](#{MRI_SOURCE_PREFIX + mriSourcePath})"
      }
    when String
      res << "[MRI](#{MRI_SOURCE_PREFIX + gem_info["mriSourcePath"]})"
    end

    case gem_info["rdocLink"]
    when Array
      gem_info["rdocLink"].each_with_index{ |rdocLink, index|
        res << "[MRI (#{index + 1})](#{rdocLink})"
      }
    when String
      res << "[RDoc](#{gem_info["rdocLink"]})"
    end

    res.join(", ")
  end

  def gem_list_for(source, ruby_version)
    exact_ruby_version = ruby_version
    major_ruby_version = ruby_version.to_f.to_s

    source.select{ |gem_info|
      gem_info["versions"][exact_ruby_version] ||
      gem_info["versions"][major_ruby_version]
    }.map{ |gem_info|
      [
        "[#{ gem_info["gem"] }](/#{ gem_info["gem"] })" +
            (gem_info["native"] ? ' **c**' : ''),
        gem_info["versions"][exact_ruby_version] ||
        gem_info["versions"][major_ruby_version],
        gem_info["description"],
        build_resource_list(gem_info)
      ].join(" | ")
    }.join("\n")
  end

  def version_matrix_for(source, ruby_versions = MATRIX_RUBY_VERSIONS)
    (
      [
        ["Gem"] + ruby_versions,
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
      }
    ).map{ |line| line.join(" | ") }.join("\n")
  end

  def default_gems_list(ruby_version = CURRENT_RUBY_VERSION)
    gem_list_for(DEFAULT_GEMS_JSON, ruby_version)
  end

  def bundled_gems_list(ruby_version = CURRENT_RUBY_VERSION)
    gem_list_for(BUNDLED_GEMS_JSON, ruby_version)
  end

  def default_gems_version_matrix
    version_matrix_for(DEFAULT_GEMS_JSON)
  end

  def bundled_gems_version_matrix
    version_matrix_for(BUNDLED_GEMS_JSON)
  end

  def default_gems_supported_version_matrix
    version_matrix_for(DEFAULT_GEMS_JSON, MATRIX_SUPPORTED_RUBY_VERSIONS)
  end

  def bundled_gems_supported_version_matrix
    version_matrix_for(BUNDLED_GEMS_JSON, MATRIX_SUPPORTED_RUBY_VERSIONS)
  end

  def default_gems_json
    DEFAULT_GEMS_FILE
  end

  def bundled_gems_json
    BUNDLED_GEMS_FILE
  end

  def gem_details(gem_info, gem_type)
    res = []

    if gem_info["rubygemsLink"]
      res << ["Project on RubyGems", gem_info["rubygemsLink"]]
    else
      res << ["Project is not published on RubyGems"]
    end

    if gem_info["sourceRepository"]
      if gem_info["sourceRepositoryIsUpstream"]
        res << ["Source repository (**upstream**)", gem_info["sourceRepository"]]
      else
        res << ["Source repository", gem_info["sourceRepository"]]
      end
    end

    case gem_info["mriSourcePath"]
    when Array
      gem_info["mriSourcePath"].each_with_index{ |mriSourcePath, index|
        res << ["MRI source on GitHub (part #{index + 1})", (MRI_SOURCE_PREFIX + mriSourcePath)]
      }
    when String
      res << ["MRI source on GitHub", (MRI_SOURCE_PREFIX + gem_info["mriSourcePath"])]
    end

    case gem_info["rdocLink"]
    when Array
      gem_info["rdocLink"].each_with_index{ |rdocLink, index|
        res << ["RDoc API documentation (part #{index + 1})", rdocLink]
      }
    when String
      res << ["RDoc API documentation", gem_info["rdocLink"]]
    end

    res.map{ |line|
      if line[1]
        "- [#{ line[0] }](#{ line[1] })"
      else
        "- #{ line[0] }"
      end
    }.join("\n")
  end

  def gem_details_properties(gem_info, gem_type)
    res = []

    if gem_type == "bundled"
      res << ["This gem is a **bundled** gem"]
    else
      res << ["This gem is a **default** gem"]
    end

    if gem_info["autoRequire"]
      res << ["The library **is required automatically**"]
    else
      res << ["Call `require \"#{require_path_of(gem_info)}\"` to use this library"]
    end

    if gem_info["native"]
      res << ["The library **does contain** native extensions"]
    else
      res << ["The library is written in Ruby, there are **no native extensions**"]
    end

    if gem_info["maintainer"]
      res << ["Current maintainer(s): " + Array(gem_info["maintainer"]).join(", ")]
    elsif gem_type != "bundled"
      res << ["This library is currently **unmaintained**"]
    end

    res.map{ |line|
      if line[1]
        "- [#{ line[0] }](/#{ line[1] })"
      else
        "- #{ line[0] }"
      end
    }.join("\n")
  end

  def gem_details_versions(gem_info)
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
      "- **" + gem_version + "** in Ruby " + ruby_versions_range
    }.join("\n")
  end

  def require_path_of(gem_info)
    gem_info["gem"].tr "-", "/"
  end

  def dev_version_warning(ruby_version)
    if ruby_version > CURRENT_RUBY_VERSION
      "**Warning:** This Ruby version has not been relaesed, yet. Standard gem data might still change."
    end
  end

  def heading(current_page, gem_info = nil, ruby_version = nil)
    current_page.data.heading ||
    gem_info && "Gem:<br/>#{ gem_info["gem"] }" ||
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
end