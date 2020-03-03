require 'sequel'
require 'eh_micro'

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
ENV['DATABASE_NAME'] ||= 'member_relationship_service'
db_name = ENV['DATABASE_NAME']

if ENV['DATABASE_URL']
  DB = Sequel.connect(
    ENV['DATABASE_URL'],
    max_connections: (ENV['DATABASE_POOL'] || 4).to_i
  )
else
  if ENV['APP_ENV'] == 'development'
    Sequel.connect(DB_CONFIG) do |db|
      res = db.execute 'SELECT 1 AS result FROM pg_database '\
        "WHERE datname='#{db_name}'"
      db.execute "CREATE DATABASE #{db_name}" if res != 1
    end
  end

  DB = Sequel.connect(DB_CONFIG.merge(database: db_name))
end
