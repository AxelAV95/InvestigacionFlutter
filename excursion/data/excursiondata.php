<?php
include_once 'data.php';
include '../domain/excursion.php';

class ExcursionData extends Database{

    public function __construct(){

    }

    //Insertar
    public function insertarExcursion($excursion){
        try {
            $pdo = Database::conectar();
            $stm = $pdo->prepare("CALL insertarExcursion(?,?,?,?,?,?)");

            $descripcion = $excursion->getDescripcion();
            $fecha =  $excursion->getFecha();
            $precio = $excursion->getPrecio();
            $estado = $excursion->getEstado();
            $lugar = $excursion->getLugar();
            $cantidad = $excursion->getCantidad();

            $stm ->bindParam(1,$descripcion,PDO::PARAM_STR);
            $stm ->bindParam(2,$fecha,PDO::PARAM_STR);
            $stm ->bindParam(3,$precio,PDO::PARAM_INT);
            $stm ->bindParam(4,$estado,PDO::PARAM_INT);
            $stm ->bindParam(5,$lugar,PDO::PARAM_STR);
            $stm ->bindParam(6,$cantidad,PDO::PARAM_INT);
        
            $resultado = $stm->execute();
            Database::desconectar();

        }catch(PDOException $e) {
            
            $resultado = 0;
        }
            
            
        return $resultado;
    }

    //Modificar
    public function modificarExcursion($excursion){
        try {

            $pdo = Database::conectar();
            $stm = $pdo->prepare("CALL modificarExcursion(?,?,?,?,?,?,?)");

            $id = $excursion->getId();
            $descripcion = $excursion->getDescripcion();
            $fecha =  $excursion->getFecha();
            $precio = $excursion->getPrecio();
            $estado = $excursion->getEstado();
            $lugar = $excursion->getLugar();
            $cantidad = $excursion->getCantidad();

            $stm ->bindParam(1,$id,PDO::PARAM_INT);
            $stm ->bindParam(2,$descripcion,PDO::PARAM_STR);
            $stm ->bindParam(3,$fecha,PDO::PARAM_STR);
            $stm ->bindParam(4,$estado,PDO::PARAM_INT);
            $stm ->bindParam(5,$lugar,PDO::PARAM_STR);
            $stm ->bindParam(6,$cantidad,PDO::PARAM_INT);
            $stm ->bindParam(7,$precio,PDO::PARAM_STR);
            $stm->execute();
            $row = $stm->fetch(PDO::FETCH_ASSOC);
            $resultado = $row['modificado'] ?? 4; //4 significa que no devolvió ninguna fila
            Database::desconectar();
        }catch(PDOException $e) {
            error_log("Error al modificar: " . $e->getMessage());  
            $resultado = 2;
        }

        return $resultado;
    }

    //Eliminar
    public function eliminarExcursion($id){
        try {
            $pdo = Database::conectar();
            $stm = $pdo->prepare("CALL eliminarExcursion(?)");
            $stm ->bindParam(1,$id,PDO::PARAM_INT);
            $stm->execute();
            $row = $stm->fetch(PDO::FETCH_ASSOC);
            $resultado = $row['eliminado'] ?? 4; //4 significa que no devolvió ninguna fila
            Database::desconectar();
        }catch(PDOException $e) {      
            error_log("Error al eliminar: " . $e->getMessage());              
            $resultado = 2;
        }
        return $resultado;
    }
    


    //Obtener
    public function obtenerExcursiones() {
        try {
            $pdo = Database::conectar();
            $stm = $pdo->prepare("CALL obtenerExcursiones()");
            $stm->execute();
            $excursiones = $stm->fetchAll(PDO::FETCH_ASSOC);
            Database::desconectar();
            return $excursiones;
        } catch (PDOException $e) {
            error_log("Error al obtener las excursiones: " . $e->getMessage());
            return null;
        }
    }
    
    

    //Obtener datos de excursion
    public function obtenerDatosExcursion($id) {
        try {
            $pdo = Database::conectar();
            $stm = $pdo->prepare("CALL obtenerDatosExcursion(?)");
            $stm ->bindParam(1,$id,PDO::PARAM_INT);
            $stm->execute();
            $excursiones = $stm->fetchAll(PDO::FETCH_ASSOC);
            Database::desconectar();
            return $excursiones;
        } catch (PDOException $e) {
            error_log("Error al obtener los datos de excursiones: " . $e->getMessage());
            return null;
        }
    }

    //Obtener estados
    public function obtenerEstados() {
        try {
            $pdo = Database::conectar();
            $stm = $pdo->prepare("CALL obtenerEstados()");
            $stm->execute();
            $estados = $stm->fetchAll(PDO::FETCH_ASSOC);
            Database::desconectar();
            return $estados;
        } catch (PDOException $e) {
            error_log("Error al obtener los estados: " . $e->getMessage());
            return null;
        }
    }
}

?>

<?php

    /*$data = new ExcursionData();
    $excursion = new Excursion();
            $excursion->setDescripcion("dd");
            $excursion->setFecha("13-05-2023");
            $excursion->setPrecio(99999);
            $excursion->setEstado(1);
            $excursion->setLugar("siuu");
            $excursion->setCantidad(2);
    echo $res = $data->insertarExcursion($excursion);*/
?>