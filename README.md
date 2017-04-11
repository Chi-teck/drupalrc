# Drupal RC

Useful Bash funcitons for Drupal development.

## Installation

Download _.drupalrc_ file into your home directory and source it from _.bashrc_ file. In order to make use of bash completions you need to download _drupal.complete.sh_ file into _/etc/bash_comletion.d_ directory. Note that actual path of bash completion directory can differ on your system.

```bash
# Quck install.
url=https://raw.githubusercontent.com/Chi-teck/drupalrc/master
wget -P$HOME $url/.drupalrc && echo source ~/.drupalrc >> ~/.bashrc &&
sudo wget -P /etc/bash_completion.d $url/drupal.complete.sh
```
Log out and log in again for the changes to take effect.

## Functions

### droot
Print absolute path to Drupal root directory.

### dcd
Quick navigation between Drupal directories.
```bash
dcd views # core/modules/viws
dcd files # sites/default/files
dcd contrib # modules/contrib
dcd themes # themes
dcd # Drupal root directory
```

## dl
Download Drupal projects using Composer or Drush (depends on Drupal version).
```bash
dl admin_toolbar token feeds
```

## dcr
Rebuild Drupal caches using `drush cr` or `drush cc all` (depends on Drupal version).

## dconf
Open specified configuration file in default editor.
```bash
dconf # settings.php
dconf settings.local.php # settings.local.php
dconf services.yml # services.yml
```

## dbin
Execute scripts from _vendor/bin_ directory.
```bash
dbin phpcbf --help
```

## drupal
Launcher for Drupal console.

## drush
Launcher for Drush.

## drupalcs
Check code against Drupal coding standards using PHP code sniffer.
```bash
drupalcs modules/custom/foo
```

## dunit
Launcher for PHPUnit.
```bash
dunit tests/src/Functional/SomeTest.php
```

## dtest
Launcher for _run-scripts.sh_.
```bash
dtest --url http://localhost/drupal . # The URL can be configured in settings.local.php.
```

## dready
Prepare _sites/default_ directory for new installation process.

## License
GNU General Public License, version 2.
