if %w[production staging].include?(ENV['APP_ENV'])
  use Rack::Cors do
    allow do
      origins '*'
      resource '*',
               headers: :any,
               methods: %i[get post delete put patch options]
    end
  end
elsif ENV['APP_ENV'] == 'development'
  use Rack::Cors do
    allow do
      origins 'localhost:3000', '127.0.0.1:3000'
      resource '*',
               headers: :any,
               methods: %i[get post delete put patch options],
               credentials: true
    end
  end
end
