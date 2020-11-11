# Include the Ruby base image (https://hub.docker.com/_/ruby)
# in the image for this application, version 2.7.2.
FROM ruby:2.7.2

# Put all this application's files in a directory called /code.
# This directory name is arbitrary and could be anything.
WORKDIR /code
COPY . /code

# Run this command. RUN can be used to run anything. In our
# case we're using it to install our dependencies.
RUN bundle install

# Tell Docker to listen on port 4567.
# Expose is NOT supported by Heroku
# EXPOSE 4567

# Run the image as a non-root user
RUN adduser myuser2
USER myuser2

# Tell Docker that when we run "docker run", we want it to
# run the following command:
CMD bundle exec rackup --host 0.0.0.0 -p $PORT
# $PORT is set by Heroku - we don't use port 4567 like we normally would with rackup