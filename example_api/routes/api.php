<?php
use App\Http\Controllers\EmployeeApiController;

use App\Http\Controllers\ProductApiController;
use App\Http\Controllers\CustomerApiController;
use App\Http\Controllers\AuthController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AttendanceController;

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
});

Route::post('/attendance/check-in', [AttendanceController::class, 'checkIn']);
Route::prefix('employee')->middleware('auth:sanctum')->group(function () {
    Route::get('', [EmployeeApiController::class, 'index']);
    Route::post('', [EmployeeApiController::class, 'store']);
    Route::get('{id}', [EmployeeApiController::class, 'show']);
    Route::put('{id}', [EmployeeApiController::class, 'update']);
    Route::delete('{id}', [EmployeeApiController::class, 'destroy']);
});
