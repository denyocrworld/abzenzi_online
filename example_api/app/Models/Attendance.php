<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Attendance extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'check_in_device_id',
        'check_out_device_id',
        'check_in_latitude',
        'check_in_longitude',
        'check_out_latitude',
        'check_out_longitude',
        'check_in_photo',
        'check_out_photo',
        'check_in_date',
        'check_out_date',
    ];

    // Hubungan dengan model User
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
