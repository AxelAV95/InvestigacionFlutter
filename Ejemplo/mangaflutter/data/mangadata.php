<?php
include_once 'data.php';
include '../domain/manga.php';

class MangaData extends Database{

    public function __construct(){

    }

    //Insertar
    public function insertarManga($manga){
        $pdo = Database::conectar();
        $stm = $pdo->prepare("CALL insertarManga(?,?)");

        $nombre = $manga->getNombre();
        $tomo = $manga->getTomo();

        $stm ->bindParam(1,$nombre,PDO::PARAM_STR);
        $stm ->bindParam(2,$tomo, PDO::PARAM_INT);

        $resultado = $stm->execute();

        $pdo = Database::desconectar();

        return $resultado;

    } 


    //Modificar
    public function modificarManga($manga){
        $pdo = Database::conectar();
        $stm = $pdo->prepare("CALL modificarManga(?,?,?)");

        $id = $manga->getId();
        $nombre = $manga->getNombre();
        $tomo = $manga->getTomo();

        $stm ->bindParam(1,$id,PDO::PARAM_INT);
        $stm ->bindParam(2,$nombre, PDO::PARAM_STR);
        $stm ->bindParam(3,$tomo, PDO::PARAM_INT);

        $resultado = $stm->execute();

        $pdo = Database::desconectar();

        return $resultado;

    }


    //Eliminar
    public function eliminarManga($id){
        $pdo = Database::conectar();
        $stm = $pdo->prepare("CALL eliminarManga(?)");

        $stm ->bindParam(1,$id,PDO::PARAM_INT);

        $resultado = $stm->execute();

        return $resultado;
    }


    //Obtener todos
    public function obtenerMangas() {
        $pdo = Database::conectar();
        $stm = $pdo->prepare("CALL obtenerMangas()");
        $stm->execute();
        Database::desconectar();
        return $stm->fetchAll(PDO::FETCH_ASSOC);
    }


    //Obtener uno en específico
    public function obtenerDatosManga($id) {
        $pdo = Database::conectar();
        $stm = $pdo->prepare("CALL obtenerDatosManga(?)");
        $stm ->bindParam(1,$id,PDO::PARAM_INT);
        $stm->execute();
        Database::desconectar();
        return $stm->fetchAll(PDO::FETCH_ASSOC);
    }
}

?>