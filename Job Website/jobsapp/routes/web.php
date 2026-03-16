<?php

use App\Http\Controllers\RegisterUserController;
use App\Http\Controllers\SessionController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\JobListingController;

// Static Routes
Route::view('/', 'home');
Route::view('/contact', 'contact');

// Job Listing Routes
//Route::resource('jobs', JobListingController::class);
Route::get('/jobs', [JobListingController::class, 'index']);
Route::get('/jobs/create', [JobListingController::class, 'create']);

//The 'auth' middleware checks if the user is logged in before allowing access to 'store'
Route::post('/jobs', [JobListingController::class, 'store'])->middleware('auth');

Route::get('/jobs/{job}', [JobListingController::class, 'show']);

//'auth' ensure the user is logged in, and can edit-job, verifying user is authenticated to perform edit.
Route::get('/jobs/{job}/edit', [JobListingController::class, 'edit'])
    ->middleware('auth')
    ->can('edit', 'job');

Route::patch('/jobs/{job}', [JobListingController::class, 'update'])
    ->middleware('auth')
    ->can('edit', 'job');

Route::delete('/jobs/{job}', [JobListingController::class, 'destroy'])
    ->middleware('auth')
    ->can('edit', 'job');

// Registration Routes
Route::get('/register',[RegisterUserController::class,'create']);
Route::post('/register',[RegisterUserController::class,'store']);

//Auth Routes
Route::get('/login',[SessionController::class,'create']);
Route::post('/login',[SessionController::class,'store']);
Route::post('/logout',[SessionController::class,'destroy']);
