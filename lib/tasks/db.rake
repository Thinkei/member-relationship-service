# frozen_string_literal: true

desc 'Create migration file'
# eg: rake generate migration create_resellers
task :generate do
  if ARGV[1] == 'migration' && !ARGV[2].nil?
    timestamp = Time.new.strftime('%Y%m%d%H%M%S')
    migration_dir = Dir.pwd + '/db/migrations'
    migration_path = "#{migration_dir}/#{timestamp}_#{ARGV[2]}.rb"
    File.write(migration_path,
               "# frozen_string_literal: true\n\nSequel.migration do\nend\n")
    puts "Migration #{migration_path} created"
    Rake.application.top_level_tasks
        .delete_if.with_index { |_, index| [1, 2].include? index }
  else
    puts 'Not yet supported'
  end
end

namespace :db do
  desc 'Create database'
  task :create do
    force_to_drop = !(['--force', '-f'] & ARGV).empty?

    if ENV.key?('DATABASE_NAME')
      Rake::Task['db:drop'].invoke if force_to_drop

      Sequel.connect(DB_CONFIG) do |db|
        db.execute "CREATE DATABASE #{ENV['DATABASE_NAME']}"
      end
    else
      puts 'Missing ENV key DATABASE_NAME. No database has been created yet.'
    end
  end

  desc 'Drop database'
  task :drop do
    if ENV.key?('DATABASE_NAME')
      DB.disconnect
      Sequel.connect(DB_CONFIG) do |db|
        db.execute "DROP DATABASE IF EXISTS #{ENV['DATABASE_NAME']}"
      end
    else
      puts 'Missing ENV key DATABASE_NAME. No database has been dropped yet.'
    end
  end

  desc 'Run migrations'
  task :migrate, [:version] do |_, args|
    Sequel.extension :migration
    DB.extension :schema_dumper

    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(
        DB, 'db/migrations', target: args[:version].to_i
      )
    else
      Sequel::Migrator.run(DB, 'db/migrations')
      puts 'Migrated to latest'
    end

    # to dump the current schema
    File.open(Dir['db/schema.rb'][0], 'w') do |file|
      file << DB.dump_schema_migration(same_db: true)
    end
  end

  desc 'Rollback migrations'
  task :rollback do
    version = DB[:schema_migrations].select_map(:filename)[-2]
                                    .scan(/^\d+/)[0]
    Rake::Task['db:migrate'].execute(version: version)
  end

  desc 'Reset database'
  task :reset do
    %w[drop create migrate].each do |task_name|
      begin
        Rake::Task["db:#{task_name}"].invoke
      rescue StandardError => exc
        puts("EXCEPTION when resetting database: #{exc}")
      end
    end
  end
end
