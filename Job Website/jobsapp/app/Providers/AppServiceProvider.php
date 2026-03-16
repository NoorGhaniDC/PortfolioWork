<?php

namespace App\Providers;

use App\Models\JobListing;
use App\Models\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\ServiceProvider;
use Nette\Utils\Paginator;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        //
        Model::preventLazyLoading(true);
        //Paginator::useBootStrap();


        /*
        //IMPORTANT: The user is always a reference to currently authenticated user.
        Gate::define('edit-job', function(User $user, JobListing $job)
        {
            //Inspect if the user associated with the employer job is the same as the logged in user.
            return $job->employer->user->is($user);
        });
        */

    }
}
