# Service

This service includes:

- Sinatra
- Sequel
- Postgres
- Integrate CircleCI
- Integrate Sentry
- Integrate EH Monitoring
- Integrate Kafka: Use Karafka
- Integrate Docker and docker-compose
- Integrate Danger bot, Rubocop

# Usage

To use console:

`bundle exec tux`

To start api:

`rackup`

To start kafka subscriber

`bundle exec karafka s`

# Documentation

See [docs](docs)

# Deployment

This service is integrated with CircleCI and deployed by herocli
