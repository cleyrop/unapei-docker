<?php
$databases = array();
$config_directories = array();
$settings['hash_salt'] = 'usuCRJBIPPFeNKClUKIHhJJ8qkjL7OLfTwJP8Io9_IYg-s6MHkIS_z6txHnlc-NkYjrg24nOpw';
$settings['update_free_access'] = FALSE;
$settings['class_loader_auto_detect'] = FALSE;
$settings['file_private_path'] = $app_root . '/' . $site_path . '/files/privates';
$settings['container_yamls'][] = $app_root . '/' . $site_path . '/services.yml';
$settings['file_scan_ignore_directories'] = [
  'node_modules',
  'bower_components',
];
$settings['entity_update_batch_size'] = 50;
$settings['config_sync_directory'] = $app_root . '/' . $site_path . '/config_usuCRJBIPPFeNKClUKIHhJJ8qkjL7OLfTwJP8Io9_IYg-s6MHkIS_z6txHnlc-NkYjrg24nOpw/sync';
assert_options(ASSERT_ACTIVE, TRUE);
\Drupal\Component\Assertion\Handle::register();
$settings['container_yamls'][] = DRUPAL_ROOT . '/sites/development.services.yml';
$config['system.logging']['error_level'] = 'verbose';
$config['system.performance']['css']['preprocess'] = FALSE;
$config['system.performance']['js']['preprocess'] = FALSE;
$settings['cache']['bins']['render'] = 'cache.backend.null';
$settings['cache']['bins']['discovery_migration'] = 'cache.backend.memory';
$settings['cache']['bins']['page'] = 'cache.backend.null';
$settings['cache']['bins']['dynamic_page_cache'] = 'cache.backend.null';
$settings['rebuild_access'] = FALSE;
$settings['skip_permissions_hardening'] = TRUE;
$databases['default']['default'] = array (
  'database' => getenv("DRUPAL_DATABASE_NAME"),
  'username' => getenv("DRUPAL_DATABASE_USER"),
  'password' => getenv("DRUPAL_DATABASE_PASSWORD"),
  'prefix' => '',
  'host' => getenv("DRUPAL_DATABASE_HOST"),
  'port' => getenv("DRUPAL_DATABASE_PORT_NUMBER"),
  'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
  'driver' => 'mysql',
);
$settings['trusted_host_patterns'] = array(
  '^local-codatalab\.eu',
);
$config['shield.settings']['shield_enable'] = FALSE;