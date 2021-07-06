# Cran Indexer

## Setup the project

1. Setup the database: Copy the file `config/database.yml.example` to `config/database.yml` and replace the credentials in the file by your local credentials.

2. `bundle install`

3. Create the database and apply the migrations:

```
rails db:create
rails db:migrate
```

## Usage

Start sidekiq to run background jobs: `bundle exec sidekiq -C config/sidekiq.yml`

Run the rake task to fetching the R packages: `rails index_r_packages`

## Solution

1. To run a task at 12PM everyday, we can use crontab `0 12 * * * rails index_r_packages`

2. When running the task `index_r_packages`:

- All packages are fetched from `https://cran.r-project.org/src/contrib/PACKAGES`. Because the response's body is large to process at once, a stream of type `StringIO` is used to create package step by step.

- When a package is stored in the database, a callback is triggered to enqueue a background job to update the package later

- The background job will download the `tar.gz` file of the package, unzip it and parse the `DESCRIPTION` file to get more information about the package
