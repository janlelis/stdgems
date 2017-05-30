require 'middleman-gh-pages'

desc 'Deploy to stdgems.org'
# task :deploy => :publish do
task :deploy do
  sh 'git checkout website && rake publish && git checkout gh-pages && git pull origin gh-pages && git push production gh-pages:gh-pages'
end
