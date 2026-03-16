<?php

namespace App\Policies;

use Illuminate\Auth\Access\Response;
use App\Models\JobListing;
use App\Models\User;

class JobListingPolicy
{
    public function edit(User $user, JobListing $job)
    {
        return $job->employer->user->is($user);
    }
}
