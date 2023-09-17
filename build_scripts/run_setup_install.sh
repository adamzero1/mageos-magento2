#!/bin/bash

SEARCH=$1
REDIS=$2
VARNISH=$3
RABBITMQ=$4
DEN=$5

SEARCH_ENGINE_TYPE=${SEARCH%%:*}
SEARCH_ENGINE_VERSION=${SEARCH##*:}

case "$SEARCH" in
  elasticsearch:5*)
    SEARCH_TYPE="elasticsearch5"
    SEARCH_HOST="elasticsearch"
    ;;
  elasticsearch:6*)
    SEARCH_TYPE="elasticsearch6"
    SEARCH_HOST="elasticsearch"
    ;;
  elasticsearch:7* | elasticsearch:8*)
    SEARCH_TYPE="elasticsearch7"
    SEARCH_HOST="elasticsearch"
    ;;
  opensearch:*)
    SEARCH_TYPE="opensearch"
    SEARCH_HOST="opensearch"
    ;;
  *)
    # Default values
    SEARCH_TYPE="elasticsearch7"
    SEARCH_HOST="elasticsearch"
    ;;
esac

declare -a PARAMETERS
PARAMETERS+=(--backend-frontname=admin --db-host=db --db-name=magento --db-user=magento --db-password=magento)

if [[ -n $REDIS ]]; then
  PARAMETERS+=(--session-save=redis --session-save-redis-host=redis --session-save-redis-port=6379 --session-save-redis-db=2 --cache-backend=redis --cache-backend-redis-server=redis --cache-backend-redis-db=0 --cache-backend-redis-port=6379 --page-cache=redis --page-cache-redis-server=redis --page-cache-redis-db=1 --page-cache-redis-port=6379)
fi

if [[ -n $VARNISH ]]; then
  PARAMETERS+=(--http-cache-hosts=varnish:80)
fi

if [[ -n $RABBITMQ ]]; then
  PARAMETERS+=(--amqp-host=rabbitmq --amqp-port=5672 --amqp-user=guest --amqp-password=guest)
fi

if [[ $SEARCH_TYPE == "opensearch" ]]; then
  PARAMETERS+=(--opensearch-host=$SEARCH_HOST --opensearch-port=9200 --opensearch-index-prefix=magento2 --opensearch-enable-auth=0 --opensearch-timeout=15)
else
  PARAMETERS+=(--search-engine=$SEARCH_TYPE --elasticsearch-host=$SEARCH_HOST --elasticsearch-port=9200 --elasticsearch-enable-auth=0 --elasticsearch-index-prefix=magento2)
fi

${DEN} env exec -T php-fpm bin/magento setup:install "${PARAMETERS[@]}"
