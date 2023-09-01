FROM ruby:3.2.2
ADD . /parking_control
WORKDIR /parking_control
RUN bundle install

EXPOSE 4567

CMD ["/bin/bash"]
