FROM ruby:alpine

# Setup
RUN set -x && apk update && apk upgrade && apk add --no-cache \
  gnupg gcc g++ make unzip curl openssh-client git bash
RUN gem install bundler

WORKDIR /usr/src/

RUN git clone https://github.com/jerrywdlee/yaml_2_resume.git app

WORKDIR /usr/src/app

RUN bundle install
RUN curl https://oscdl.ipa.go.jp/IPAexfont/IPAexfont00301.zip > fonts.zip && \
  unzip -oj fonts.zip -d fonts/ && rm -rf fonts.zip

# EXPOSE 5000
# CMD ["ruby", "app.rb", "-o", "0.0.0.0", "-p", "5000"]
