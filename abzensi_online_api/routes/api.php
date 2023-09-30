<?php

use App\Http\Controllers\UserApiController;
use App\Http\Controllers\ProductApiController;
use App\Http\Controllers\CustomerApiController;
use App\Http\Controllers\AuthController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AttendanceController;
use App\Http\Controllers\UserTokenController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
 */

//api/login
//api/logout
//api/refresh
Route::post('/login', [AuthController::class, 'login']);
Route::post('/forgot-password', [AuthController::class, 'forgotPassword']);
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::post('/refresh', [AuthController::class, 'refresh']);

    Route::post('/attendance/check-in', [AttendanceController::class, 'checkIn']);
    Route::post('/attendance/check-out', [AttendanceController::class, 'checkOut']);
    Route::post('/attendance/is-check-in-today', [AttendanceController::class, 'isCheckInToday']);
    Route::post('/attendance/is-check-out-today', [AttendanceController::class, 'isCheckOutToday']);
    Route::get('/attendance/histories', [AttendanceController::class, 'histories']);

    Route::post('/tokens', [UserTokenController::class, 'store']);
});


Route::prefix('users')->middleware('auth:sanctum')->group(function () {
    Route::get('', [UserApiController::class, 'index']);
    Route::post('', [UserApiController::class, 'store']);
    Route::get('{id}', [UserApiController::class, 'show']);
    Route::put('{id}', [UserApiController::class, 'update']);
    Route::delete('{id}', [UserApiController::class, 'destroy']);
});

//api/user-tokens

// Route::resource('user-tokens', UserTokenController::class)->only([
//     'store', 'show', 'update', 'destroy'
// ]);
