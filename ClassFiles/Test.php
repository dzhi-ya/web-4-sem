<?php

  declare(strict_types=1);

  namespace App\ClassFiles;

  use Monolog\Logger;

  class Test{

    public static function test(){
      echo Logger::ALERT . PHP_EOL;
    }

  }


?>