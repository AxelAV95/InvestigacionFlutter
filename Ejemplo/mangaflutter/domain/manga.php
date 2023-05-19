<?php

class Manga{
    private $id;
    private $nombre;
    private $tomo;
 
    /**
     * Get the value of id
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set the value of id
     */
    public function setId($id): self
    {
        $this->id = $id;

        return $this;
    }

    /**
     * Get the value of nombre
     */
    public function getNombre()
    {
        return $this->nombre;
    }

    /**
     * Set the value of nombre
     */
    public function setNombre($nombre): self
    {
        $this->nombre = $nombre;

        return $this;
    }

    /**
     * Get the value of tomo
     */
    public function getTomo()
    {
        return $this->tomo;
    }

    /**
     * Set the value of tomo
     */
    public function setTomo($tomo): self
    {
        $this->tomo = $tomo;

        return $this;
    }
}

?>