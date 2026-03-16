<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\JobListing;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Gate;

class JobListingController extends Controller
{
    public function index(){
        $jobs = JobListing::with('employer')->latest()->simplePaginate(3);
        return view('jobs.index',['jobs' => $jobs] );
    }
    public function create(){
        return view('jobs.create');
    }
    public function show(JobListing $job){
        return view('jobs.show', ['job' => $job]);
    }
    public function store(){
        //Validation
        request()->validate([
            'title' => ['required', 'min:5'],
            'salary' => ['required'],
        ]);

        //persist data to database
        JobListing::create([
            'title' => request('title'),
            'salary' => request('salary'),
            'employer_id' => 1
        ]);

        return redirect('/jobs');
    }


    public function edit(JobListing $job)
    {
        return view('jobs.edit', ['job'=> $job]);
    }


    public function update(JobListing $job){
        //Step 1 - Validation
        request()->validate([
            'title' => ['required', 'min:5'],
            'salary' => ['required']
        ]);

        //Step 2 - Authorize (ON HOLD)

        //Step 3 - Find & Update Job Listing
        //$job = JobListing::findOrFail($id);

        $job->update([
            'title' => request('title'),
            'salary' => request('salary')
        ]);

        //Step 4 - Redirect to job listing.
        return redirect('/jobs/'. $job->id);
    }
    public function destroy(JobListing $job){
        $job->delete();

        //Step 3: Redirection
        return redirect('/jobs');
    }
}
