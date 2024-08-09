# 1. Specify the base image
FROM ruby:3.2

# # 2. Install dependencies
# RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
# Install dependencies for building native extensions and PostgreSQL client
RUN apt-get update -qq && apt-get install -y \
    nodejs postgresql-client \
    build-essential \
    libpq-dev \
    libmsgpack-dev \
    libsass-dev

# 3. Set the working directory
WORKDIR /app

# 4. Copy Gemfile and Gemfile.lock to the container
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# 5. Install Ruby dependencies
RUN bundle install --jobs=4 --retry=5

# 6. Copy the rest of the application code to the container
COPY . /app

# 7. Precompile assets (if applicable)
RUN bundle exec rake assets:precompile
# RUN bundle exec rake db:migrate
# RUN bundle exec rails runner db/seeds/artists.rb
# RUN bundle exec rails runner db/seeds/tracks.rb
# RUN bundle exec rails runner db/seeds/playlists.rb
# RUN bundle exec rails runner db/seeds/playlist_items.rb

# 8. Expose the port that the app runs on
EXPOSE 80

# 9. Specify the command to run the app
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
