<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Arr;


class JobListing extends Model {

    /*

    public static function all():array
    {
        return[
            [
                'id' => 1,
                'title' => 'Director',
                'salary' => '$150,000',
            ],
            [
                'id' => 2,
                'title' => 'Junior Programmer',
                'salary' => '$60,000',

            ],
            [
                'id' => 3,
                'title' => 'Intermediate Programmer',
                'salary' => '$80,000',
            ]
        ];
    }

    public static function find(int $id): array {



        $job = Arr:: first(static::all(), fn($job) => $job['id'] == $id);


        if(!$job){
            abort(404, 'JobListing not found');
        }

        return $job;
    }

*/
    use HasFactory;

    //protected $fillable = ['title', 'salary', 'id'];

    protected $guarded = [];


    public function employer()
    {
    return $this->belongsTo(Employer::class);
    }

    public function tags()
    {
        return $this->belongsToMany(Tag::class, foreignPivotKey: 'job_listing_id');
    }


}
