<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\ValidationException;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Support\Facades\Password;
use Illuminate\Foundation\Auth\SendsPasswordResetEmails;
use Illuminate\Support\Facades\Mail;
use App\Mail\HelloWorldEmail;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $credentials = $request->only('email', 'password');
        if (Auth::attempt($credentials)) {
            $user = Auth::user();
            $token = $user->createToken('authToken')->plainTextToken;
            $user['token'] = $token;

            return response()->json([
                'success' => true,
                'data' => $user
            ], 200);
        }

        return response()->json([
            'success' => false,
            'data' => [
                "message" => 'Wrong email or password'
            ]
        ], 200);
    }

    public function logout(Request $request)
    {
        $user = $request->user();
        $user->tokens()->delete();

        return response()->json(['message' => 'Logged out'], 200);
    }

    public function refresh(Request $request)
    {
        $user = $request->user();
        $user->tokens()->delete();
        $token = $user->createToken('authToken')->plainTextToken;

        return response()->json(['token' => $token], 200);
    }

    public function forgotPassword(Request $request)
    {
        $res =   Mail::raw('Hello World', function ($message) {
            $message->to("abdulwandi@gmail.com")
                ->subject('Test Dev');
        });
        return response()->json(['message' => $res], 200);
    }
}
