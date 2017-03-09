# CCIinsta

## Development

Clone the repo. Copy and fill `.env` file:

    cp .env.example .env

Run the application:

    docker-compose up --build

Create database:

    docker-compose exec website rails db:create db:migrate
    docker-compose exec website rails db:create db:migrate RAILS_ENV=test

Ensure specs are green:

    docker-compose exec website rspec

And you are ready to go :)

## Demo

http://194.28.50.95:3000/
