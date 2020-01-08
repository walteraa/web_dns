FROM ruby:2.6.3

# Install mysql dependency
RUN apt-get install -y default-libmysqlclient-dev


# Creating app structure and installing gem dependencies
RUN mkdir /web_dns_app
WORKDIR /web_dns_app
COPY Gemfile /web_dns_app/Gemfile
COPY Gemfile.lock /web_dns_app/Gemfile.lock
RUN bundle install
COPY . /web_dns_app

# Expose port and start server
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

