<?php

namespace App\Console;

use App\Models\User;
use App\Services\AttendanceService;
use App\Services\NotificationService;
use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;

class Kernel extends ConsoleKernel
{
    /**
     * Define the application's command schedule.
     */
    protected function schedule(Schedule $schedule): void
    {
        // $schedule->command('inspire')->hourly();
        $schedule->call(function () {
            $users = User::all();
            // $users = User::where("role", "user")->get();
            foreach ($users as $user) {
                NotificationService::sendFCMNotificationToUser($user->id, "Selamat, kamu mendapatkan diskon 50%", "F10045");
            }
        })->everySeconds(10);
    }

    /**
     * Register the commands for the application.
     */
    protected function commands(): void
    {
        $this->load(__DIR__ . '/Commands');

        require base_path('routes/console.php');
    }
}
