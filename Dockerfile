FROM ruby:3.1.0

WORKDIR /shorten-url
COPY Gemfile /shorten-url/Gemfile
COPY Gemfile.lock /shorten-url/Gemfile.lock
COPY config/credentials/development.key /shorten-url/config/credentials/development.key
RUN bundle install
RUN yarn install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
