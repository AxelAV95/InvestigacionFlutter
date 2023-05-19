<?php

include '../data/mangadata.php';

class MangaBusiness{

    private $mangaData;

    public function __construct(){
        $this->mangaData = new MangaData();
    }
 
    public function insertarManga($manga){
        return $this->mangaData->insertarManga($manga);
    }

    public function modificarManga($manga){
        return $this->mangaData->modificarManga($manga);
    }

    public function eliminarManga($id){
        return $this->mangaData->eliminarManga($id);
    }

    public function obtenerMangas(){
        return $this->mangaData->obtenerMangas();
    }

    public function obtenerDatosManga($id){
        return $this->mangaData->obtenerDatosManga($id);
    }

}

?>