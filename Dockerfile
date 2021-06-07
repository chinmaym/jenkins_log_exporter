FROM fluent/fluentd:v1.12-1
LABEL maintainer="chinmay.m92@gmail.com"

# Use root account to use apk
USER root

# below RUN includes plugin as examples elasticsearch is not required
# you may customize including plugins as you wish
RUN apk add --no-cache --update --virtual .build-deps \
        sudo build-base ruby-dev \
 && sudo gem install fluent-plugin-elasticsearch \
 && sudo gem install elasticsearch-xpack \
 && sudo gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem /home/fluent/.gem/ruby/2.5.0/cache/*.gem \
 ## Edit the lines below to use CURL to get ca_chain file
 # && apk --no-cache add curl \
 # && curl <ca_chain_file> 
 # && cp ca-chain.crt /opt/ \
 # && apk del curl

# To restrict the memory usage for the fluentd container
ENV RUBY_GC_HEAP_OLDOBJECT_LIMIT_FACTOR=1.2
COPY fluent.conf /fluentd/etc/
COPY entrypoint.sh /bin/
RUN chmod +x /bin/entrypoint.sh
COPY template.json /fluentd/etc

USER fluent
