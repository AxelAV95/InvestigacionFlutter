<?php

   
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Methods: POST, GET, OPTIONS, DELETE");
    header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");


    include '../business/excursionbusiness.php';

    if($_SERVER['REQUEST_METHOD'] == "GET"){
		$excursionBusiness = new ExcursionBusiness();

        if(isset($_GET['metodo'])){
            $metodo = $_GET['metodo'];
            if($metodo == "obtener"){
                $excursiones =$excursionBusiness->obtenerExcursiones();
                if(!empty($excursiones)){
                    echo json_encode($excursiones);
                } else {
                    echo json_encode(array("statusCode"=>400, "message"=>"No se encontraron excursiones"));
                }
            } else if($metodo == "obtenerDatosExcursion"){
                if(isset($_GET['id']) && !empty($_GET['id'])){
                    $id = $_GET['id'];
                    $excursiones =$excursionBusiness->obtenerDatosExcursion($id);
                    if(!empty($excursiones)){
                        echo json_encode($excursiones);
                    } else {
                        echo json_encode(array("statusCode"=>400, "message"=>"No se encontró la excursión con el id proporcionado"));
                    }
                } else {
                    echo json_encode(array("statusCode"=>400, "message"=>"El parámetro 'id' es requerido"));
                }
            } else if($metodo == "obtenerEstados"){
                $estados =$excursionBusiness->obtenerEstados();
                if(!empty($estados)){
                    echo json_encode($estados);
                } else {
                    echo json_encode(array("statusCode"=>400, "message"=>"No se encontraron estados"));
                }
            } else {
                echo json_encode(array("statusCode"=>400, "message"=>"El parámetro 'metodo' no es válido"));
            }
        } else {
            echo json_encode(array("statusCode"=>400, "message"=>"El parámetro 'metodo' es requerido"));
        }
  		
	}else if($_SERVER['REQUEST_METHOD'] == "POST"){
		
		$json = file_get_contents('php://input');
		$data = json_decode($json);

        if(isset($data->metodo) && $data->metodo == "insertar"){
            if(isset($data->descripcion) && isset($data->fecha) && isset($data->precio) && isset($data->estado) && isset($data->lugar) && isset($data->cantidad)){

                $excursion = new Excursion();
                $excursion->setDescripcion($data->descripcion);
                $excursion->setFecha($data->fecha);
                $excursion->setPrecio($data->precio);
                $excursion->setEstado($data->estado);
                $excursion->setLugar($data->lugar);
                $excursion->setCantidad($data->cantidad);
    
                $excursionBusiness = new ExcursionBusiness();
    
                $resultado = $excursionBusiness ->insertarExcursion($excursion);
    
                if($resultado == 1){
                    echo json_encode(array("statusCode"=>200,"message"=>"Insertado con éxito"));    
                } else {
                    echo json_encode(array("statusCode"=>400, "message"=>"Ocurrió un error al insertar la excursión"));
                }
    
            } else {
                echo json_encode(array("statusCode"=>400, "message"=>"Faltan parámetros requeridos para insertar una excursión"));
            }
        }else {
            echo json_encode(array("statusCode"=>400, "message"=>"El parámetro 'metodo' no es válido o no se proporcionó"));
        }

	}else if($_SERVER['REQUEST_METHOD'] == "PUT"){
        $json = file_get_contents('php://input');
		$data = json_decode($json);

        if(isset($data->id) &&isset($data->descripcion) && isset($data->fecha) && isset($data->precio) && isset($data->estado) && isset($data->lugar) && isset($data->cantidad)){

            $excursion = new Excursion();
            $excursion->setId($data->id);
            $excursion->setDescripcion($data->descripcion);
            $excursion->setFecha($data->fecha);
            $excursion->setPrecio($data->precio);
            $excursion->setEstado($data->estado);
            $excursion->setLugar($data->lugar);
            $excursion->setCantidad($data->cantidad);
            

            $excursionBusiness = new ExcursionBusiness();

            $resultado = $excursionBusiness ->modificarExcursion($excursion);

            if($resultado == 0){
                echo json_encode(array("statusCode"=>400, "message"=>"El registro no existe"));	
            }else if($resultado == 1){
                echo json_encode(array("statusCode"=>200,"message"=>"Actualizado con éxito"));	
            }else if($resultado == 2){
                echo json_encode(array("statusCode"=>400, "message"=>"Error en la base de datos"));	
            }else{
                echo json_encode(array("statusCode"=>400, "message"=>"No se pudo actualizar la excursión"));	
            }

        }else{
            echo json_encode(array("statusCode"=>400, "message"=>"Faltan parámetros requeridos para actualizar una excursión"));
        }
        

    }else if($_SERVER['REQUEST_METHOD'] === "DELETE"){
        if(isset($_GET['id']) && is_numeric($_GET['id'])){
            $id = $_GET['id'];
            $excursionBusiness = new ExcursionBusiness();
    
            $resultado = $excursionBusiness->eliminarExcursion($id);
            if($resultado == 0){
                echo json_encode(array("statusCode"=>400, "message"=>"El registro no existe"));	
            }else if($resultado == 1){
                echo json_encode(array("statusCode"=>200, "message"=>"Eliminado con éxito"));	
            }else if($resultado == 2){
                echo json_encode(array("statusCode"=>400, "message"=>"Error en la base de datos"));	
            }else{
                echo json_encode(array("statusCode"=>400, "message"=>"No se pudo eliminar la excursión"));	
            }
        } else {
            echo json_encode(array("statusCode"=>400, "message"=>"El parámetro 'id' es inválido"));	
        }
    }
    
?>