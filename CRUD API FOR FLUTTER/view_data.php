<?php 
    $arr = [];
    include 'connection.php';
    $connection = connection();
    $sql = "SELECT * FROM users";
    $exec = mysqli_query($connection, $sql);
    while ($row = mysqli_fetch_assoc($exec)) {
        $arr[] = $row;
    }
    print_r(json_encode($arr));