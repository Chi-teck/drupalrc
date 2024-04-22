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
Downloads Drupal projects using Composer.
```bash
dl admin_toolbar token feeds
```
## dle
Downloads and enables Drupal modules.

## dcr
Rebuilds Drupal caches using `drush cr`.

## dconf
Opens specified configuration file in default editor.
```bash
dconf # settings.php
dconf settings.local.php # settings.local.php
dconf services.yml # services.yml
```

## dbin
Executes scripts from _vendor/bin_ directory.
```bash
dbin phpcbf --help
```

## dcomposer
Launcher for Composer.
```bash
dcomposer show
```

## dcg
Launcher for Drupal Code Generator.

## drush
Launcher for Drush.

## drupalcs
Checks the code against Drupal coding standards using PHP code sniffer.
```bash
drupalcs modules/custom/foo
```

## d-phpcbf (d-cbf)

Automatically tries to fix PHPCS issues using PHPCBF tool.

```bash
d-phpcbf modules/custom/foo
```

## dunit
Launcher for PHPUnit.
```bash
dunit tests/src/Functional/SomeTest.php
```

## dready
Prepares _sites/default_ directory for new installation process.

## d-phpstan (d-stan)

Runs PHPStan analyze.

```bash
d-phpstan .
```

> [!NOTE]
> If the local `phpstan.neon` file is not found, a contrib version of the file 
> from Drupal CI will be downloaded to a temporary directory.

## License
GNU General Public License, version 2.
