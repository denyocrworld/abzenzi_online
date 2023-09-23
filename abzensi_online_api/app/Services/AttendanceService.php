<?php

namespace App\Services;

use App\Models\Attendance;

class AttendanceService
{
    public function checkIn($data)
    {
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

    public function checkOut($data)
    {
        $attendance = Attendance::where("user_id", $data['user_id'])
            ->update([
                'check_out_device_id' => $data['check_out_device_id'],
                'check_out_latitude' => $data['check_out_latitude'],
                'check_out_longitude' => $data['check_out_longitude'],
                'check_out_photo' => $data['check_out_photo'],
                'check_out_date' => now(),
            ]);
        return $attendance;
    }

    public function isCheckInToday($user_id)
    {
        $todayAttendances = Attendance::where("user_id", $user_id)
            ->whereDate('check_in_date', now()->toDateString())->get();
        $isCheckIn = count($todayAttendances) > 0;
        return $isCheckIn;
    }

    public function isCheckOutToday($user_id)
    {
        $todayAttendances = Attendance::where("user_id", $user_id)
            ->whereNotNull('check_in_date')
            ->whereNotNull('check_out_date')
            ->get();
        $isCheckIn = count($todayAttendances) > 0;
        return $isCheckIn;
    }

    public function getHistories($user_id)
    {
        $todayAttendances = Attendance::where("user_id", $user_id)->get();
        return $todayAttendances;
    }
}
