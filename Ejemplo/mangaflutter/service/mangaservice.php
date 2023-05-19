<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: DELETE");
header("Access-Control-Allow-Methods: PUT");
header("Access-Control-Allow-Headers: Content-Type");

include '../business/mangabusiness.php';
 
if($_SERVER['REQUEST_METHOD'] == "GET"){
    $mangaBusiness = new MangaBusiness();
      $mangas = $mangaBusiness->obtenerMangas();
      echo json_encode($mangas);
}else if($_SERVER['REQUEST_METHOD'] == "POST"){
    //se utiliza en PHP para obtener el contenido de la solicitud HTTP entrante
    $json = file_get_contents('php://input');
    $data = json_decode($json);

    if($data->metodo == "insertar"){
        $manga = new Manga();
        $manga->setNombre($data->nombre);
        $manga->setTomo($data->tomo);
       
        $mangaBusiness = new MangaBusiness();

        $resultado = $mangaBusiness->insertarManga($manga);

        if($resultado == 1){
                echo json_encode(array("statusCode"=>200));	
        }else{
                echo json_encode(array("statusCode"=>400));	
        }
    }
}else if($_SERVER['REQUEST_METHOD'] == "PUT"){
    $json = file_get_contents('php://input');
    $data = json_decode($json);

    $manga = new Manga();
    $manga->setId($data->id);
    $manga->setNombre($data->nombre);
    $manga->setTomo($data->tomo);
    $mangaBusiness = new MangaBusiness();

    $resultado =  $mangaBusiness->modificarManga($manga);

    if($resultado == 1){
            echo json_encode(array("statusCode"=>200));	
    }else{
            echo json_encode(array("statusCode"=>400));	
    }
}else if($_SERVER['REQUEST_METHOD'] === "DELETE"){
    
    $id = $_GET['id'];

    $mangaBusiness = new MangaBusiness();
    
    $resultado = $mangaBusiness->eliminarManga($id);

    if($resultado == 1){
            echo json_encode(array("statusCode"=>200));	
    }else{
            echo json_encode(array("statusCode"=>400));	
    }
}

?>