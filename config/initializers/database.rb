require 'sequel'
require 'eh_micro'

DB = if !ENV['DATABASE_URL'].to_s.empty?
       Sequel.connect(
         ENV['DATABASE_URL'],
         max_connections: (ENV['DATABASE_POOL'] || 4).to_i
       )
     elsif ENV['APP_ENV'] == 'development'
       db_config = {
         adapter: ENV['DATABASE_ADAPTER'] || 'postgres',
         database: 'postgres',
         host: ENV['DATABASE_HOST'] || 'localhost',
         port: (ENV['DATABASE_PORT'] || 5432).to_i,
         user: ENV['DATABASE_USR'],
         password: ENV['DATABASE_PWD'],
         max_connections: (ENV['DATABASE_POOL'] || 4).to_i
       }
       db_config[:logger] = EhMicro::Log.logger
       DB_CONFIG = db_config.freeze

       ENV['DATABASE_NAME'] ||= 'member_relationship_service'
       db_name = ENV['DATABASE_NAME']

       Sequel.connect(DB_CONFIG) do |db|
         res = db.execute 'SELECT 1 AS result FROM pg_database '\
           "WHERE datname='#{db_name}'"
         db.execute "CREATE DATABASE #{db_name}" if res != 1
       end

       Sequel.connect(DB_CONFIG.merge(database: db_name))
     end

DB.extension :pg_array, :pg_json
Sequel::Model.plugin :validation_helpers
Sequel::Model.plugin :json_serializer
Sequel::Model.plugin :association_dependencies
Sequel::Model.plugin :timestamps
