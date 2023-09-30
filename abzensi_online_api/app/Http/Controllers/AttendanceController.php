<?php

namespace App\Http\Controllers;

use App\Helpers\URLDownloader;
use App\Http\Controllers\Controller;
use App\Models\Attendance;
use Illuminate\Support\Facades\Storage;
use App\Services\AttendanceService;
use App\Services\FaceRecognitionService;
use App\Services\NotificationService;
use Carbon\Carbon;

class AttendanceController extends Controller
{
    public function checkIn()
    {
        $id = request()->user()["id"];
        $attendanceService = new AttendanceService();
        $isCheckIn = $attendanceService->isCheckInToday($id);
        if ($isCheckIn) {
            return response()->json([
                "data" => [
                    "message" => "Already check in today!"
                ]
            ]);
        }

        $data = request()->all();
        $url = $data["check_in_photo"];

        $filename = URLDownloader::download($url);


        $user_face = "$id.jpg";
        $user_uploaded_face = $filename;

        //TODO: FaceRecognition masih lemot, dibagian ini masih 20detik! 
        $is_recognized = FaceRecognitionService::recognize($user_face, $user_uploaded_face);

        if ($is_recognized) {
            $attendanceService = new AttendanceService();
            $attendanceService->checkIn([
                'user_id' => $id,
                'check_in_device_id' => $data['check_in_device_id'],
                'check_in_latitude' => $data['check_in_latitude'],
                'check_in_longitude' => $data['check_in_longitude'],
                //TODO: ini seharusnya ngambil dari field photo dari Users
                'check_in_photo' => $url,
                'check_in_date' => Carbon::now(),
            ]);
        }

        //seharusnya ada di dalam block if($is_recognized)
        NotificationService::sendFCMNotificationToUser($id, "Berhasil check in hari ini!", "");

        return response()->json([
            'data' => [
                'is_recognized' => $is_recognized == "true" ? true : false,
            ]
        ]);
    }

    public function checkOut()
    {
        $id = request()->user()["id"];
        $attendanceService = new AttendanceService();
        $isCheckOut = $attendanceService->isCheckOutToday($id);
        if ($isCheckOut) {
            return response()->json([
                "data" => [
                    "message" => "Already check out today!"
                ]
            ]);
        }

        $data = request()->all();
        $url = $data["check_out_photo"];

        $filename = URLDownloader::download($url);

        $id = request()->user()["id"];
        $user_face = "$id.jpg";
        $user_uploaded_face = $filename;

        //TODO: FaceRecognition masih lemot, dibagian ini masih 20detik! 
        $is_recognized = FaceRecognitionService::recognize($user_face, $user_uploaded_face);

        if ($is_recognized) {
            $attendanceService = new AttendanceService();
            $attendanceService->checkOut([
                'user_id' => $id,
                'check_out_device_id' => $data['check_out_device_id'],
                'check_out_latitude' => $data['check_out_latitude'],
                'check_out_longitude' => $data['check_out_longitude'],
                //TODO: ini seharusnya ngambil dari field photo dari Users
                'check_out_photo' => $url,
                'check_out_date' => Carbon::now(),
            ]);
        }

        return response()->json([
            'data' => [
                'is_recognized' => $is_recognized == "true" ? true : false,
            ]
        ]);
    }

    public function isCheckInToday()
    {
        $id = request()->user()["id"];
        $attendanceService = new AttendanceService();
        $isCheckIn = $attendanceService->isCheckInToday($id);
        return response()->json([
            "data" => [
                "is_check_in_today" => $isCheckIn
            ]
        ]);
    }

    public function isCheckOutToday()
    {
        $id = request()->user()["id"];
        $attendanceService = new AttendanceService();
        $isCheckIn = $attendanceService->isCheckOutToday($id);
        return response()->json([
            "data" => [
                "is_check_out_today" => $isCheckIn
            ]
        ]);
    }

    public function histories()
    {
        $id = request()->user()["id"];
        $attendanceService = new AttendanceService();
        $attendanceHistories = $attendanceService->getHistories($id);

        return response()->json([
            "data" => $attendanceHistories
        ]);
    }
}
