<x-layout>
    <x-slot:heading>
        Login
    </x-slot:heading>

    <form method="post" action="/login">
        @csrf

        <div class="space-y-12">
            <div class="border-b border-gray-900/10 pb-12">

                <x-form-field>
                    <x-form-label for="email">Email</x-form-label>

                    <div class="mt-2">
                        <x-form-input type="email"
                                      name="email"
                                      id="email"
                                      :value="old('email')"
                                      required></x-form-input>

                        <x-form-error name ="email"/>

                    </div>
                </x-form-field>

                <x-form-field>
                    <x-form-label for="password">Password</x-form-label>

                    <div class="mt-2">
                        <x-form-input type="password"
                                      name="password"
                                      id="password"
                                      required></x-form-input>

                        <x-form-error name ="password"/>

                    </div>
                </x-form-field>
            </div>
        </div>




        <div class="mt-6 flex items-center justify-end gap-x-6">
            <button type="button" class="text-sm/6 font-semibold text-gray-900">Cancel</button>
            <x-form-button>Login</x-form-button>
        </div>

    </form>

</x-layout>
