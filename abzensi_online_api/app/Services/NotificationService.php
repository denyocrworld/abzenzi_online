<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;

class NotificationService
{
    static function send($fcmToken, $title, $body)
    {
        $url = 'https://fcm.googleapis.com/fcm/send';
        $headers = [
            'Authorization' => 'key=' . env('FCM_SERVER_KEY'),
            'Content-Type' => 'application/json',
        ];

        $payload = [
            'to' => $fcmToken,
            'notification' => [
                'title' => $title,
                'body' => $body,
                'click_action' => 'OPTIONAL_CLICK_ACTION',
            ],
            'data' => $data,
        ];

        $response = Http::withHeaders($headers)->post($url, $payload);

        return $response->json();
    }
}
