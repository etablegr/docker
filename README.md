# Etable PHP docker images

Docker images used for http://www.e-table.gr application build pipelines and infrastructure.

# Docker images:

* `etable/php7.2`: Php version 7.2 with all all php dependencies installed.
* `etable/php7.2-dev`: An `etable/php7.2` image with the Xdebug installed
* `etable/php7.0.8`: Php version 7.0.8 with all all php dependencies installed, used in codeingiter projects.
* `etable/php7.0.8-dev` : Php version 7.0.8 with xdebug installed
* `etable/node`: Nodejs with gulp for building the frontend assets

| `etable/php7.0.8-dev` is not being developped firther due to failue of the XDEBUG to install. It is being kept as legacy form.

## Xdebug Settings:
The xdebug is configured via the following enviromental variables:

Variable | Default Value | Purpoce
--- | --- | ---
`XDEBUG_HOST` | N/A | The url where the Xdebug will connect into. (Keep in mind that the Xdebug is the **client** and not the server.)
`XDEBUG_PORT` | 9000 | The port where the xdebug will connect back.
`XDEBUG_IDE_KEY` | N/A | The IDE Key.
`XDEBUG_DBGP` | Whether the GBGP protocol will be used or not

## Codebuild Enviromental Variables

Variable | Description
--- | ---
`USER` | The Docker Hub user.
`TOKEN` | The Docker Hub personal token.

# Maintainer notes

1. Use git-flow
2. For release run the following commands
   ```
      VERSION=$(date +"%Y%m%d%H%M%S");
      # Look on documentation bellow for ^VERSION_FILE^ 
      echo $VERSION > ^VERSION_FILE^

      git flow release start $VERSION
      git flow release finish $VERSION
   ````
The ^VERSION_FILE^ is a file that records the version for each container for the correct file consult the table bellow:

Version File | images
--- | ---

VERSION_NODEJS | `etable/node`
VERSION_PHP_72 | `etable/php7.2` , `etable/php7.2-dev`
VERSION_PHP_708 | `etable/php7.0.8`
