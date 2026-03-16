<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tag extends Model
{
    use HasFactory;

    public function jobListings()
    {
        return $this->belongsToMany(JobListing::class,  relatedPivotKey: 'job_listing_id');
    }
}
