<?php
class VehiclesDao{
  public $conn;
  public function __construct(){

    // https://freedb.tech/dashboard/
    
  // $servername = "sql.freedb.tech";
  // $username = "freedb_carsharing";
  // $password = "eDdnDb7kTR&28Du";
  // $name="freedb_carsharing";

  $servername = "localhost";
  $username = "root";
  $password = "864950sa";
  $name="freedb_carsharing";

  try {
    $this->conn = new PDO("mysql:host=$servername;dbname=$name", $username, $password);
    // set the PDO error mode to exception
    $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  } catch(PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
  }
}
/**
* List all records from the database
*/
  public function get_all(){
  $stmt = $this->conn->prepare("SELECT * FROM vehicles");
  $stmt->execute();
  return $stmt->fetchAll(PDO::FETCH_ASSOC);
  }

/*
* List individual records
*/
    public function get_by_id($id){
        $stmt = $this->conn->prepare("SELECT * FROM vehicles WHERE id = :id");
        $stmt->execute(['id' => $id]);
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        return reset($result);
      }
/**
* Insert new vehicles into database
*/

  public function add($vehicle){
  $stmt = $this->conn->prepare("INSERT INTO vehicles (car_brand, car_model, license_plate, price_per_hour) VALUES (:car_brand, :car_model, :license_plate, :price_per_hour)");
  $stmt->execute($vehicle);
  $vehicle['id'] = $this->conn->lastInsertId();
  return $vehicle;
  }

/**
* Delete vehicle from the database
*/
  public function delete($id){
  $stmt = $this->conn->prepare("DELETE FROM vehicles WHERE id=:id");
  $stmt->bindParam(':id', $id);
  $stmt->execute();
  }

/**
* Update vehicles
*/
  public function update($vehicle){
  $stmt = $this->conn->prepare("UPDATE vehicles SET car_brand=:car_brand, car_model=:car_model, license_plate=:license_plate, price_per_hour=:price_per_hour WHERE id=:id");
  $stmt->execute($vehicle);
  return $vehicle;
  }
}
