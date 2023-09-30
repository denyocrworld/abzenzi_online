<?php

use App\Services\NotificationService;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return NotificationService::sendFCMNotification(
        "efM0yMaZSFKEtixHrpRoml:APA91bGDzBIgBHgSFt_Y2l4R9-ESk4Q-sgFB-IPAI2OesfVz7o6swLmdVh5l3EgIKAAvHWtG2mr3rxZQkqpwzLGbBnpQ1bIaJa9ZuWERZYqiHTf2BdoWGGnorBEIvswdyzrTkrGVq8P8",
        "Test kirim dari laravel",
        "Test aja"
    );
});
