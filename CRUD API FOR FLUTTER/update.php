<?php 
    include 'connection.php';
    $connection = connection();
    $email = "";
    $password = "";
    $id="";
    $arr = [];

    if(isset($_POST['email'])){
        $email = $_POST['email'];
    }else{
        return null;
    }

    if(isset($_POST['password'])){
        $password = $_POST['password'];
    }else{
        return null;
    }

    if(isset($_POST['id'])){
        $id = $_POST['id'];
    }else{
        return null;
    }

    $sql = "UPDATE users
    SET email = '$email', password = '$password'
    WHERE id = $id;";
    

    $exec = mysqli_query($connection, $sql);

    if ($exec) {
        $arr["success"] = "true";
    } else {
        $arr["success"] = "false";
    }

    print(json_encode($arr));
?>
