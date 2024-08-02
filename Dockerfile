# 1. Specify the base image
FROM ruby:3.2

# 2. Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# 3. Set the working directory
WORKDIR /app

# 4. Copy Gemfile and Gemfile.lock to the container
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# 5. Install Ruby dependencies
RUN bundle install

# 6. Copy the rest of the application code to the container
COPY . /app

# 7. Precompile assets (if applicable)
RUN bundle exec rake assets:precompile

# 8. Expose the port that the app runs on
EXPOSE 3000

# 9. Specify the command to run the app
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
