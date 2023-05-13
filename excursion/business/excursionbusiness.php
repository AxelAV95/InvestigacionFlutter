<?php

include '../data/excursiondata.php';

class ExcursionBusiness{
    private $excursionData;

    public function __construct(){
        $this->excursionData = new ExcursionData();
    }

    public function insertarExcursion($excursion){
        return $this->excursionData->insertarExcursion($excursion);
    }
    public function modificarExcursion($excursion){
        return $this->excursionData->modificarExcursion($excursion);
    }

    public function eliminarExcursion($id){
        return $this->excursionData->eliminarExcursion($id);
    }

    public function obtenerExcursiones(){
        return $this->excursionData->obtenerExcursiones();
    }

    public function obtenerDatosExcursion($id){
        return $this->excursionData->obtenerDatosExcursion($id);
    }

    public function obtenerEstados(){
        return $this->excursionData->obtenerEstados();
    }

}

?>