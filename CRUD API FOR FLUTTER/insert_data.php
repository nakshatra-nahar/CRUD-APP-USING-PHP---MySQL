<?php 
    include 'connection.php';
    $connection = connection();
    $email = "";
    $password = "";
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

    $sql = "INSERT INTO users (email, password)
    VALUES ('$email', '$password')";

    $exec = mysqli_query($connection, $sql);

    if ($exec) {
        $arr["success"] = "true";
    } else {
        $arr["success"] = "false";
    }

    print(json_encode($arr));
?>
