<?php

namespace App\Http\Controllers;

use App\Models\UserToken;
use Illuminate\Http\Request;

class UserTokenController extends Controller
{
    public function store(Request $request)
    {
        $data = $request->validate([
            'token' => 'required|string',
        ]);

        $id = request()->user()["id"];
        $data["id_user"] = $id;

        $currentUserToken = UserToken::where("token", $data['token'])->first();
        if (!$currentUserToken) {
            UserToken::create($data);
        }

        return response()->json([], 201);
    }

    public function show($id)
    {
        $token = UserToken::findOrFail($id);
        return response()->json($token);
    }

    public function update(Request $request, $id)
    {
        $token = UserToken::findOrFail($id);
        $data = $request->validate([
            'id_user' => 'required|integer|exists:users,id',
            'token' => 'required|string',
        ]);

        $token->update($data);

        return response()->json($token);
    }

    public function destroy($id)
    {
        $token = UserToken::findOrFail($id);
        $token->delete();

        return response()->json(null, 204);
    }
}
