<x-layout>
    <x-slot:heading>
        Create a New Job Listing
    </x-slot:heading>


    <form method="post" action="/jobs">

        @CSRF

        <div class="space-y-12">
            <div class="border-b border-gray-900/10 pb-12">
                <h2 class="text-base/7 font-semibold text-gray-900">Create Job Listing</h2>
                <p class="mt-1 text-sm/6 text-gray-600">Please provide the job listing details.</p>

                <div class="mt-10 grid grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6">


                       <x-form-field>
                        <x-form-label for="title">Job Title</x-form-label>

                        <div class="mt-2">
                            <x-form-input type="text"
                                          name="title"
                                          id="title"
                                          autocomplete="Computer Programmer"
                                          required></x-form-input>

                            <x-form-error name ="title"/>

                        </div>
                       </x-form-field>
                    </div>

                <div class="mt-10 grid grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6">


                    <x-form-field>
                        <x-form-label for="salary">Salary</x-form-label>

                        <div class="mt-2">
                            <x-form-input type="text"
                                          name="salary"
                                          id="salary"
                                          autocomplete="$50,000"
                                          required></x-form-input>

                            <x-form-error name ="salary"/>

                        </div>
                    </x-form-field>
                </div>

                </div>
            </div>


        <div class="mt-6 flex items-center justify-end gap-x-6">
            <button type="button" class="text-sm/6 font-semibold text-gray-900">Cancel</button>
            <x-form-button>Save</x-form-button>
        </div>
    </form>

</x-layout>
