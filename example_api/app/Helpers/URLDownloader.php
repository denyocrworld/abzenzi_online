<?php
namespace App\Helpers;
use Illuminate\Support\Facades\Storage;

class URLDownloader {
    public static function download($url) {
        $client = new \GuzzleHttp\Client();
        $response = $client->get($url);
        $filename = time() . '_' . '.jpg';
        Storage::disk('public')->put($filename, $response->getBody());
        return $filename;
    }
}