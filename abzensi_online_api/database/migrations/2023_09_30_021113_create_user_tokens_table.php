<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUserTokensTable extends Migration
{
    public function up()
    {
        Schema::create('user_tokens', function (Blueprint $table) {
            $table->id();
            $table->integer('id_user');
            $table->text('token');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('user_tokens');
    }
}
