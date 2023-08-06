<?php
/**
 * Copyright © Magento, Inc. All rights reserved.
 * See COPYING.txt for license details.
 */

return [
    'db-host' => 'magento2-db-1',
    'db-user' => 'root',
    'db-password' => 'magento',
    'db-name' => 'magento',
    'db-prefix' => '',
    'backend-frontname' => 'backend',
    // 'opensearch-host' => 'localhost',
    // 'opensearch-port' => 9200,
    'search-engine' => 'elasticsearch7',
    'elasticsearch-host' => 'magento2-elasticsearch-1',
    'elasticsearch-port' => 9200,
    'elasticsearch-enable-auth' => 0,
    'elasticsearch-index-prefix' => 'magento2',
    'admin-user' => \Magento\TestFramework\Bootstrap::ADMIN_NAME,
    'admin-password' => \Magento\TestFramework\Bootstrap::ADMIN_PASSWORD,
    'admin-email' => \Magento\TestFramework\Bootstrap::ADMIN_EMAIL,
    'admin-firstname' => \Magento\TestFramework\Bootstrap::ADMIN_FIRSTNAME,
    'admin-lastname' => \Magento\TestFramework\Bootstrap::ADMIN_LASTNAME,
    // 'amqp-host' => 'localhost',
    // 'amqp-port' => '5672',
    // 'amqp-user' => 'guest',
    // 'amqp-password' => 'guest',
    'consumers-wait-for-messages' => '0',
];
