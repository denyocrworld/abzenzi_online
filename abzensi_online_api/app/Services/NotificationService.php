<?php

namespace App\Services;

use App\Models\UserToken;
use Illuminate\Support\Facades\Http;
use Google_Client;

class NotificationService
{
    static public function sendFCMNotificationToUser($id_user, $title, $body, $data = [])
    {
        $tokens = UserToken::where("id_user", $id_user)->get();
        foreach ($tokens as $userToken) {
            $fcmToken = $userToken->token;
            NotificationService::sendFCMNotification($fcmToken, $title, $body);
        }
    }

    static public function sendFCMNotification($fcmToken, $title, $body, $data = [])
    {
        $url = 'https://fcm.googleapis.com/v1/projects/abzensi-online/messages:send';
        $headers = [
            'Authorization' => 'Bearer ' . NotificationService::getAccessTokenFromServiceAccount(),
            'Content-Type' => 'application/json',
        ];
        $payload = [
            'message' => [
                'token' => $fcmToken,
                'notification' => [
                    'title' => $title,
                    'body' => $body,
                ],
                "data" => [
                    "key1" =>  "value1",
                    "key2" =>  "value2"
                ]
            ],
        ];

        $response = Http::withHeaders($headers)->post($url, $payload);
        return $response->json();
    }

    static public function getAccessTokenFromServiceAccount()
    {
        $client = new Google_Client();

        // Lokasi file service-account.json yang Anda simpan
        $pathToServiceAccount = base_path('credentials.json');

        $client->useApplicationDefaultCredentials();
        $client->addScope('https://www.googleapis.com/auth/firebase.messaging');
        $client->setAuthConfig($pathToServiceAccount);

        // Dapatkan token akses
        $token = $client->fetchAccessTokenWithAssertion();

        return $token['access_token'];
    }
}
