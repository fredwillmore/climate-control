namespace :db do
  namespace :seed do
    Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].each do |filename|
      task_name = File.basename(filename, '.rb').intern
      task task_name => :environment do
        load(filename) if File.exist?(filename)
      end
    end
  end
  
  desc "Drop, create, migrate then seed the database"
  task :rebuild => :environment do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed:artists'].invoke
    Rake::Task['db:seed:tracks'].invoke
    Rake::Task['db:seed:playlists'].invoke
    Rake::Task['db:seed:playlist_items'].invoke
  end
end
