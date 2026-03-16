<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\Rules\Password;

class RegisterUserController extends Controller
{
    public function create(){
        return view('auth.register');
    }
    public function store(){
        //dd(request()->all());



        //Step 1: Validate the registration data
        $validatedAttributes = request()->validate([
           'first_name' => ['required'],
           'last_name' => ['required'],
           'email' => ['required', 'email', 'max:254'],
           'password' => [
               'required',
               'string',
               'confirmed',
               Password::min(8)
                   ->mixedCase()
                   ->letters()
                   ->numbers()
                   ->symbols(),
               ],
        ]);

        //Step 2: Create the user
        $user = User::create($validatedAttributes);

        //Step 3: Log user in
        Auth::login($user);

        //Step 4: Redirect the user
        return redirect('/jobs');
    }



}
