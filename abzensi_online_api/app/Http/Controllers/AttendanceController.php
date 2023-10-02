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
use Illuminate\Support\Facades\Log;

class AttendanceController extends Controller
{
    public $officeLatitude = -6.56746114281521;
    public $officeLongitude = 106.74193809837642;
    public $minimumDistance = 15.0;

    public function calculateDistance($sourceLatitude, $sourceLongitude, $targetLatitude, $targetLongitude)
    {
        $earthRadius = 6371000; // Earth's radius in meters (approximately)

        // Convert degrees to radians
        $sourceLatRadians = deg2rad($sourceLatitude);
        $sourceLongRadians = deg2rad($sourceLongitude);
        $targetLatRadians = deg2rad($targetLatitude);
        $targetLongRadians = deg2rad($targetLongitude);

        // Haversine formula
        $dLat = $targetLatRadians - $sourceLatRadians;
        $dLong = $targetLongRadians - $sourceLongRadians;
        $a = sin($dLat / 2) * sin($dLat / 2) +
            cos($sourceLatRadians) * cos($targetLatRadians) *
            sin($dLong / 2) * sin($dLong / 2);
        $c = 2 * atan2(sqrt($a), sqrt(1 - $a));
        $distance = $earthRadius * $c;

        return $distance; // Distance in meters
    }

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

        // tambahin logic utk check apakah koordinat-nya berjarak 10m dari kantor
        $distanceInMeter = $this->calculateDistance(
            $data['check_in_latitude'],
            $data['check_in_longitude'],
            $this->officeLatitude,
            $this->officeLongitude,
        );
        $is_too_far = $distanceInMeter > $this->minimumDistance ? true : false;
        //---------

        $filename = URLDownloader::download($url);

        $user_face = "$id.jpg";
        $user_uploaded_face = $filename;

        $is_recognized = FaceRecognitionService::recognize($user_face, $user_uploaded_face);

        if ($is_recognized && $is_too_far == false) {
            $attendanceService = new AttendanceService();
            $attendanceService->checkIn([
                'user_id' => $id,
                'check_in_device_id' => $data['check_in_device_id'],
                'check_in_latitude' => $data['check_in_latitude'],
                'check_in_longitude' => $data['check_in_longitude'],
                'check_in_photo' => $url,
                'check_in_date' => Carbon::now(),
            ]);

            NotificationService::sendFCMNotificationToUser($id, "Berhasil check in hari ini!", "");
        }

        return response()->json([
            'data' => [
                'is_recognized' => $is_recognized == "true" ? true : false,
                'is_too_far' => $is_too_far,
                'distance' => $distanceInMeter,
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



        // tambahin logic utk check apakah koordinat-nya berjarak 10m dari kantor
        $distanceInMeter = $this->calculateDistance(
            $data['check_out_latitude'],
            $data['check_out_longitude'],
            $this->officeLatitude,
            $this->officeLongitude,
        );
        $is_too_far = $distanceInMeter > $this->minimumDistance ? true : false;


        $filename = URLDownloader::download($url);

        $id = request()->user()["id"];
        $user_face = "$id.jpg";
        $user_uploaded_face = $filename;

        $is_recognized = FaceRecognitionService::recognize($user_face, $user_uploaded_face);

        if ($is_recognized && $is_too_far == false) {
            $attendanceService = new AttendanceService();
            $attendanceService->checkOut([
                'user_id' => $id,
                'check_out_device_id' => $data['check_out_device_id'],
                'check_out_latitude' => $data['check_out_latitude'],
                'check_out_longitude' => $data['check_out_longitude'],
                'check_out_photo' => $url,
                'check_out_date' => Carbon::now(),
            ]);

            NotificationService::sendFCMNotificationToUser($id, "Berhasil check out hari ini!", "");
        }

        return response()->json([
            'data' => [
                'is_recognized' => $is_recognized == "true" ? true : false,
                'is_too_far' => $is_too_far,
                'distance' => $distanceInMeter,
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

    public function resetToday()
    {
        $id = request()->user()["id"];
        $attendanceService = new AttendanceService();
        $attendanceService->resetToday($id);

        NotificationService::sendFCMNotificationToUser($id, "Yuk absen dulu hari ini!", "");

        return response()->json([
            "data" => [
                "message" => "OK"
            ]
        ]);
    }
}
