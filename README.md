# Drupal RC

Useful Bash functions for Drupal development.

## Installation

```bash
# Local installation.
url=https://raw.githubusercontent.com/Chi-teck/drupalrc/master
wget -O $HOME/.drupalrc $url/drupalrc && echo source $HOME/.drupalrc >> $HOME/.bashrc &&
wget -O $HOME/.drupal.complete.sh $url/drupal.complete.sh &&
echo source $HOME/.drupal.complete.sh >> $HOME/.bash_completion &&
mkdir $HOME/.drupal-projects && wget -P $HOME/.drupal-projects $url/drupal-projects/d{6,7,8}.txt
```

```bash
# System-wide installation
url=https://raw.githubusercontent.com/Chi-teck/drupalrc/master
wget -O /etc/drupalrc $url/drupalrc && echo source /etc/drupalrc >> /etc/bash.bashrc &&
wget -O /etc/bash_completion.d/drupal.complete.sh $url/drupal.complete.sh
mkdir /usr/share/drupal-projects && wget -P /usr/share/drupal-projects $url/drupal-projects/d{6,7,8}.txt
```

Log out and log in again for the changes to take effect.

## Functions

### droot
Print absolute path to Drupal root directory.

### dcd
Quick navigation between Drupal directories.
```bash
dcd views # core/modules/views
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
