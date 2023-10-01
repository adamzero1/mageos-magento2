#!/bin/bash

SEARCH=$1
RABBITMQ=$2
REDIS=$3

SEARCH_ENGINE_TYPE=${SEARCH%%:*}
SEARCH_ENGINE_VERSION=${SEARCH##:*}

case "$SEARCH" in
  elasticsearch:*)
    SEARCH_HOST="elasticsearch"
  ;;&
  elasticsearch:5*)
    SEARCH_ENGINE="elasticsearch5"
    SEARCH_PARAMS="'search-engine' => '$SEARCH_ENGINE', 'elasticsearch-host' => '$SEARCH_HOST', 'elasticsearch-port' => 9200,"
    ;;
  elasticsearch:6*)
    SEARCH_ENGINE="elasticsearch6"
    SEARCH_PARAMS="'search-engine' => '$SEARCH_ENGINE', 'elasticsearch-host' => '$SEARCH_HOST', 'elasticsearch-port' => 9200,"
    ;;
  elasticsearch:7* | elasticsearch:8*)
    SEARCH_ENGINE="elasticsearch7"
    SEARCH_PARAMS="'search-engine' => '$SEARCH_ENGINE', 'elasticsearch-host' => '$SEARCH_HOST', 'elasticsearch-port' => 9200,"
    ;;
  opensearch:*)
    SEARCH_ENGINE="opensearch"
    SEARCH_HOST="opensearch"
    SEARCH_PARAMS="'search-engine' => '$SEARCH_ENGINE', 'opensearch-host' => '$SEARCH_HOST', 'opensearch-port' => 9200, 'opensearch-index-prefix' => 'magento2', 'opensearch-enable-auth' => 0, 'opensearch-timeout' => 15,"
    ;;
  *)
    SEARCH_ENGINE="elasticsearch7"
    SEARCH_HOST="UKNOWN"
    SEARCH_PARAMS="'search-engine' => '$SEARCH_ENGINE', 'elasticsearch-host' => '$SEARCH_HOST', 'elasticsearch-port' => 9200,"
    ;;
esac

cat << EOL
<?php
return [
  'db-host' => 'tmp-mysql',
  'db-user' => 'root',
  'db-password' => 'magento',
  'db-name' => 'magento_integration_tests',
  'backend-frontname' => 'backend',
  $SEARCH_PARAMS
  'admin-user' => \Magento\TestFramework\Bootstrap::ADMIN_NAME,
  'admin-password' => \Magento\TestFramework\Bootstrap::ADMIN_PASSWORD,
  'admin-email' => \Magento\TestFramework\Bootstrap::ADMIN_EMAIL,
  'admin-firstname' => \Magento\TestFramework\Bootstrap::ADMIN_FIRSTNAME,
  'admin-lastname' => \Magento\TestFramework\Bootstrap::ADMIN_LASTNAME,
EOL

if [[ -n $RABBITMQ ]]; then
  cat << EOL
  'amqp-host' => 'rabbitmq',
  'amqp-port' => '5672',
  'amqp-user' => 'guest',
  'amqp-password' => 'guest',
EOL
fi

if [[ -n $REDIS ]]; then
  cat << EOL
  'session-save' => 'redis',
  'session-save-redis-host' => 'redis',
  'session-save-redis-port' => 6379,
  'session-save-redis-db' => 2,
  'session-save-redis-max-concurrency' => 20,
  'cache-backend' => 'redis',
  'cache-backend-redis-server' => 'redis',
  'cache-backend-redis-db' => 0,
  'cache-backend-redis-port' => 6379,
  'page-cache' => 'redis',
  'page-cache-redis-server' => 'redis',
  'page-cache-redis-db' => 1,
  'page-cache-redis-port' => 6379,
EOL
fi

cat << EOL
];
EOL
