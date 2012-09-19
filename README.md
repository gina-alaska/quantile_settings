## Quantile Settings

Quick app put together to manager runs using different settings

### External dependencies

* [Redis](http://redis.io/)
* Some sort of database (sqlite, postgres, mysql)

### Installation

Checkout the code

    git clone https://github.com/gina-alaska/quantile_settings.git
    cd quantile_settings
    bundle
    
Configure the database

    cp config/database.yml.example config/database.yml
    vi config/database.yml
    
Seed the database
    
    rake db:setup
    
### Start the workers

    screen bundle exec sidekiq