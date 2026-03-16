<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Employer extends Model
{
    use HasFactory;

    public function jobListings()
    {
     return $this->hasMany(JobListing::class);
    }


    public function user(): BelongsTo{
        return $this->belongsTo(User::class);
    }

}
