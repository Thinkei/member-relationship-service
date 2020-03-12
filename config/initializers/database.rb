require 'sequel'
require 'eh_micro'

if ENV['DATABASE_URL']
  DB = Sequel.connect(
    ENV['DATABASE_URL'],
    max_connections: (ENV['DATABASE_POOL'] || 4).to_i
  )
else
  db_config = {
    adapter: ENV['DATABASE_ADAPTER'] || 'postgres',
    database: 'postgres',
    host: ENV['DATABASE_HOST'] || 'localhost',
    port: (ENV['DATABASE_PORT'] || 5432).to_i,
    user: ENV['DATABASE_USR'],
    password: ENV['DATABASE_PWD'],
    max_connections: (ENV['DATABASE_POOL'] || 4).to_i
  }
  DB_CONFIG = db_config.freeze
  db_name = ENV['DATABASE_NAME']
  DB = Sequel.connect(DB_CONFIG.merge(database: db_name))
end

Sequel::Model.plugin :validation_helpers
