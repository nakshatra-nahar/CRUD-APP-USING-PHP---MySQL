<?php
    function connection(){
        $conn = mysqli_connect('localhost', 'root', '','crud_app_in_flutter');
        return $conn;
    }
?>