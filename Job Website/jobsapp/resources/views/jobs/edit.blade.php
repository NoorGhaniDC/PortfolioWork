<x-layout>
    <x-slot:heading>
        Edit Job - {{$job ->title}}
    </x-slot:heading>

    <form method="post" action="/jobs/{{$job -> id}}">

        @CSRF
        @method('PATCH')

        <div class="space-y-12">
            <div class="border-b border-gray-900/10 pb-12">


                <div class="mt-10 grid grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6">
                    <div class="sm:col-span-4">
                        <label for="title" class="block text-sm/6 font-medium text-gray-900">Job Title</label>
                        <div class="mt-2">
                            <input type="text" name="title" id="title" autocomplete="Computer Programmer"
                                   class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1
                                          ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset
                                          focus:ring-indigo-600 sm:text-sm/6" required value ="{{$job->title}}">

                            @error('title')
                                <p class="text-xs text-red-500 font-semibold mt-1">{{$message}}</p>
                            @enderror
                        </div>
                    </div>

                    <div class="sm:col-span-4">
                        <label for="salary" class="block text-sm/6 font-medium text-gray-900">Salary</label>
                        <div class="mt-2">
                            <input type="text" name="salary" id="salary" autocomplete="$50,000"
                                   class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset
                                          ring-gray-300 placeholder:text-gray-400 focus:ring-2
                                          focus:ring-inset focus:ring-indigo-600 sm:text-sm/6" required value ="{{$job->salary}}">

                            @error('salary')
                                <p class="text-xs text-red-500 font-semibold mt-1">{{$message}}</p>
                            @enderror

                        </div>
                    </div>

                </div>
            </div>

        </div>
        <div class="mt-6 flex items-center justify-between gap-x-6">
            <div class="flex items-center">
                <button form="delete-form" class="text-red-500 text-sm font bold">Delete</button>
            </div>

            <div class="flex items-center gap-x-6">
            <button type="button" class="text-sm/6 font-semibold text-gray-900">Cancel</button>

            <button type="submit" class="rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold
            text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2
            focus-visible:outline-offset-2 focus-visible:outline-indigo-600">Update</button>
            </div>
        </div>
    </form>

    <form id="delete-form" method="post" action="/jobs/{{$job->id}}" class="hidden">
        @csrf
        @method('delete')
    </form>

</x-layout>
