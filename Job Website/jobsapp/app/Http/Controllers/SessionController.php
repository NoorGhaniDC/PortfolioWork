<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;


use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Validation\ValidationException;


class SessionController extends Controller
{
    public function create(){
        return view('auth.login');
    }

    public function store(Request $request){
        //dd(request()->all());

        //Step 1: Check rate limiting
        $this->ensureIsNotRateLimited($request);

        //Step 2: Check request parameters
        $attributesValidated = $request->validate([
            'email' =>['required','email'],
            'password' =>['required']
        ]);

        //Step 3: Attempt to log in the user
        if(!Auth::attempt($attributesValidated)){
            RateLimiter::hit($this->throttleKey($request),60);

            throw ValidationException::withMessages([
                'email' => 'Authentication failed. Credentials do not match.'
            ]);
        }

        //Step 4: Log in if user succeeds, regenerate a session token and reset the rate limiter
        RateLimiter::clear($this->throttleKey($request));
        $request->session()->regenerate();

        //Step 5: Redirect the user
        return redirect('/jobs');


    }

    protected function ensureIsNotRateLimited(request $request)
    {
        if(RateLimiter::tooManyAttempts($this->throttleKey($request), 3)){
            $seconds = RateLimiter::availableIn($this->throttleKey($request));
            throw ValidationException::withMessages([
                'email' => "Too many login attempts. Please try again in $seconds seconds."
            ]);
    }
}
    protected function throttleKey(Request $request)
    {
        return strtolower($request->input('email').'|'.$request->ip());
    }

    public function destroy()
    {
        Auth::logout();
        return redirect('/');
    }
}
