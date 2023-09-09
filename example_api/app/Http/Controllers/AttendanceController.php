<?php

namespace App\Http\Controllers;

use App\Helpers\URLDownloader;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Storage;
use App\Services\AttendanceService;
use App\Services\FaceRecognitionService;

class AttendanceController extends Controller
{
    public function checkIn()
    {
        $data = request()->all();
        $url = $data["check_in_photo"];
        $filename = URLDownloader::download($url);

        $id = request()->user()["id"];
        $user_face = "$id.jpg";
        $user_uploaded_face = $filename;
        $output = FaceRecognitionService::recognize($user_face, $user_uploaded_face);

        $attendanceService = new AttendanceService();
        $attendanceService->create([
            'user_id' => $id,
            'check_in_device_id' => $data['check_in_device_id'],
            'check_in_latitude' => $data['check_in_latitude'],
            'check_in_longitude' => $data['check_in_longitude'],
            //TODO: ini seharusnya ngambil dari field photo dari Users
            'check_in_photo' => $url,
            'check_in_date' => now(),
        ]);

        return response()->json([
            'recognized' => $output == "true" ? true : false,
        ]);
    }
}
