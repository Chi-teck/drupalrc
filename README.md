# Drupal RC

Useful Bash functions for Drupal development.

## Installation

```bash
# Local installation.
url=https://raw.githubusercontent.com/Chi-teck/drupalrc/master &&
wget -O $HOME/.drupalrc $url/drupalrc &&
echo source $HOME/.drupalrc >> $HOME/.bashrc &&
wget -O $HOME/.drupal.complete.sh $url/drupal.complete.sh &&
echo source $HOME/.drupal.complete.sh >> $HOME/.bash_completion
```

```bash
# System-wide installation (run as super user).
url=https://raw.githubusercontent.com/Chi-teck/drupalrc/master &&
wget -O /etc/drupalrc $url/drupalrc &&
echo source /etc/drupalrc >> /etc/bash.bashrc &&
wget -O /etc/bash_completion.d/drupal.complete.sh $url/drupal.complete.sh
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
Download Drupal projects using Composer.
```bash
dl admin_toolbar token feeds
```
## dle
Download and enable Drupal modules.

## dcr
Rebuild Drupal caches using `drush cr`.

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

## dcomposer
Launcher for Composer.
```bash
dcomposer show
```

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

## dready
Prepare _sites/default_ directory for new installation process.

## License
GNU General Public License, version 2.
