<?php 
    include "connection.php";
    $id = "";
    $connection = connection();
    if(isset($_GET['id'])){
        $id = $_GET['id'];
    }else{
        return null;
    }
    $sql = "DELETE FROM `users` WHERE `users`.`id` = $id;";

    $exec = mysqli_query($connection, $sql);

    if ($exec) {
        $arr["success"] = "true";
    } else {
        $arr["success"] = "false";
    }

    print(json_encode($arr));
