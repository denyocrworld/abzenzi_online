<?php
namespace App\Services;
use App\Models\Attendance;

class AttendanceService {
    public function create($data) {
        $attendance = Attendance::create([
            'user_id' => $data['user_id'],
            'check_in_device_id' => $data['check_in_device_id'],
            'check_in_latitude' => $data['check_in_latitude'],
            'check_in_longitude' => $data['check_in_longitude'],
            'check_in_photo' => $data['check_in_photo'],
            'check_in_date' => now(),
        ]);
        return $attendance;
    }
}