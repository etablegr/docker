<?php

define('LOGFILE',__DIR__.'/signal_'.getmypid().'.log');

function shutdown()
{
    $date=(new DateTime())->format("%Y-%m-%d %H:%i:%s");
    echo "[${date}] received kill signal".PHP_EOL;
    file_put_contents(LOGFILE,"[${date}] received kill signal".PHP_EOL,FILE_APPEND);
    exit(1);
}

declare(ticks=1);        
pcntl_async_signals(true);
        
pcntl_signal(SIGINT, 'shutdown'); // Call $this->shutdown() on SIGINT
pcntl_signal(SIGTERM, 'shutdown'); // Call $this->shutdown() on SIGTERM
pcntl_signal(SIGCHLD, 'shutdown');

$date=(new DateTime())->format("%Y-%m-%d %H:%i:%s");
echo "[${date}] started".PHP_EOL;
file_put_contents(LOGFILE, "[${date}] started".PHP_EOL,FILE_APPEND);

while(true){
    $date=(new DateTime())->format("%Y-%m-%d %H:%i:%s");
    echo "[${date}] Doing Stuff".PHP_EOL;
    file_put_contents(LOGFILE,"[${date}] Doing Stuff".PHP_EOL,FILE_APPEND);
    sleep(1);
}

