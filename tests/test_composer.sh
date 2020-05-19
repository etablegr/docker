#! /usr/bin/env bash

echo "Testing whether composer exists"

declare -a images=( 'etable/php7.2-dev' 'etable/php7.2-dev' 'etable/php7.0.8' )

for image in "${images[@]}"; do
 container_name="test_composer_"$(echo $image | tr \/ _ )
 docker run --name $container_name $image composer --version
 sleep 1
 status=$(docker inspect $container_name --format='{{.State.ExitCode}}')
 docker rm $container_name

 echo $image' ==> '$status
 if [ "$status" != "0" ]; then
    echo "Composer not Installed on image ${image}"
    exit $status
 fi
done;