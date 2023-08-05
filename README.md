# Ruby [Standard Gems](https://stdgems.org)

## About the Gemified Standard Library

Large portions of Ruby's standard library come in the form of [RubyGems](https://rubygems.org), which can be updated independently from Ruby.

There are two different kinds of standard gems:

- **Default gems:** These gems are part of Ruby and you can always require them directly. You cannot remove them. They are maintained by Ruby core.

- **Bundled gems:** The behavior of bundled gems is similar to normal gems, but they get automatically installed when you install Ruby. They can be uninstalled and they are maintained outside of Ruby core.

There are a few libraries that will stay non-gem default libraries, because they are very dependent on the specific Ruby version.


## About the stdgems.org project

This repository contains four JSON files:

- [default_gems.json](/default_gems.json)
- [bundled_gems.json](/bundled_gems.json)
- [libraries.json](/libraries.json)
- [stdgems.json](/stdgems.json)

The first two files contain data about all default and bundled gems and which Ruby version comes with which version of the gem. The third file contains data about all the non-gemified standard libraries. The fourth JSON combines the above ones into a single unified list.

Go to [stdgems.org](https://stdgems.org) to easily browse the standard gem data and more info.
