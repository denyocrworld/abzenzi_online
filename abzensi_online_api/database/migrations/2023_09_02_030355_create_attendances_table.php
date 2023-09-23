<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('attendances', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id');
            $table->string('check_in_device_id');
            $table->string('check_out_device_id')->nullable();
            $table->decimal('check_in_latitude');
            $table->decimal('check_in_longitude');
            $table->decimal('check_out_latitude')->nullable();
            $table->decimal('check_out_longitude')->nullable();
            $table->string('check_in_photo');
            $table->string('check_out_photo')->nullable();
            $table->dateTime('check_in_date');
            $table->dateTime('check_out_date')->nullable();
            $table->timestamps();
            $table->foreign('user_id')->references('id')->on('users');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('attendances');
    }
};
