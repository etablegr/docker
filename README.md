# Etable php docker images

Etable phph images used for http://etable.gr application build pipelines and launching the website.

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