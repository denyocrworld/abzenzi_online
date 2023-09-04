<?php

namespace App\Services;

class FaceRecognitionService
{
    public static function recognize($user_face, $user_uploaded_face)
    {
        $path = base_path("python_app\\recognize.py");
        //TODO: ini seharusnya ngambil dari field photo dari Users
        $known_image_path = base_path("public\\storage\\$user_face");
        $unknown_image_path = base_path("public\\storage\\$user_uploaded_face");

        $command = "python $path $known_image_path $unknown_image_path";
        $output = exec($command, $result, $return_var);
        return $output;
    }
}
