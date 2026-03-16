<x-layout>

    <x-slot:heading>
        Jobs Listing Page
    </x-slot:heading>


    <div class="space-y-4">
        @foreach($jobs as $job)

                <a href ="/jobs/{{$job['id']}}" class="block px-4 py-6 border border-grey-200 round-lg" >

                    <div class="font-bold text-blue-500 text-sm">{{ $job ->employer->name }}</div>

                <strong>{{$job['title']}} </strong>: pays{{$job ['salary'] }} per year
                </a>

        @endforeach
    </div>

    {{$jobs->Links() }}


</x-layout>
