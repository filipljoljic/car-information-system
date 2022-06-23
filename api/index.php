<?php

require_once 'dao/VehiclesDao.class.php';
require_once '../vendor/autoload.php';

Flight::register('vehiclesDao', 'VehiclesDao');

Flight::route('/', function(){
  echo 'HI';
});

Flight::route('/cars', function(){
    echo 'hello world!';
  });

Flight::route('GET /vehicles', function(){
  Flight::json(Flight::vehiclesDao()->get_all());
});

Flight::route('GET /vehicles/@id', function($id){
  Flight::json(Flight::vehiclesDao()->get_by_id($id));
});

Flight::route('POST /vehicles', function(){
  Flight::json(Flight::vehiclesDao()->add(Flight::request()->data->getData()));
});

Flight::route('DELETE /vehicles/@id', function($id){
  Flight::vehiclesDao()->delete($id);
  Flight::json(["message" => "deleted"]);
});

Flight::route('PUT /vehicles/@id', function($id){
  $data = Flight::request()->data->getData();
  $data['id'] = $id;
  Flight::json(Flight::vehiclesDao()->update($data));
});

Flight::start();
?>
