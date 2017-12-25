# Ruby [Standard Gems](https://stdgems.org)

## About the Gemified Standard Library

Ruby's standard library is in the process of being gemified. More and more libraries will be turned into [RubyGems](https://rubygems.org), which can be updated independently from Ruby.

There are two different kinds of standard gems:

- **Default gems:** These gems are part of Ruby and you can always require them directly. You cannot remove them. They are maintained by Ruby core.

- **Bundled gems:** The behavior of bundled gems is similar to normal gems, but they get automatically installed when you install Ruby. They can be uninstalled and they are maintained outside of Ruby core.

## About the stdgems project

This repository contains two JSON files:

- [default_gems.json](/default_gems.json)
- [bundled_gems.json](/bundled_gems.json)

They contain data about all default and bundled gems and which versions come with which Ruby version.

## About stdgems.org

Go to [stdgems.org](https://stdgems.org) to easily browse the standard gem data and more info.