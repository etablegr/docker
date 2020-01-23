<?php

function shutdown()
{
    $date=(new DateTime())->format("%Y-%m-%d %H:%i:%s");
    echo "[${date}] received kill signal".PHP_EOL;
    exit(1);
}

declare(ticks=1);        
pcntl_async_signals(true);
        
pcntl_signal(SIGINT, 'shutdown'); // Call $this->shutdown() on SIGINT
pcntl_signal(SIGTERM, 'shutdown'); // Call $this->shutdown() on SIGTERM
pcntl_signal(SIGCHLD, 'shutdown');

$date=(new DateTime())->format("%Y-%m-%d %H:%i:%s");
echo "[${date}] started".PHP_EOL;

while(true){
    $date=(new DateTime())->format("%Y-%m-%d %H:%i:%s");
    echo "[${date}] Doing Stuff".PHP_EOL;
    sleep(1);
}

