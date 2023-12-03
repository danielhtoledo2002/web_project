<section class="bg-gray-900/90 p-12 rounded-sm flex flex-col gap-10 text-center">
    <h1 class="text-xl">Sign Up</h1>
    <form class="flex flex-col gap-4">
        <input type="text" id="email" name="email" placeholder="Email" class="bg-black/50 px-4 py-2 rounded-sm border-none focus:outline outline-blue-600 outline-offset-2 outline-2">
        <input type="password" id="password" name="password" placeholder="Password" class="bg-black/50 px-4 py-2 rounded-sm border-none focus:outline outline-blue-600 outline-offset-2 outline-2">
        <input type="password-reenter" id="password-reenter" name="password-reenter" placeholder="Re-enter Password" class="bg-black/50 px-4 py-2 rounded-sm border-none focus:outline outline-blue-600 outline-offset-2 outline-2">
        <span class="text-left">
            <input type="checkbox" id="auto-signin" name="auto-signin">
            <label for="auto-signin" class="text-sm">Automatically Sign In</label>
            <br>
            <input type="checkbox" id="remember-me" name="remember-me">
            <label for="remember-me" class="text-sm">Remember me</label>
        </span>
        <input type="submit" value="Create Account" class="bg-sky-600 p-2 rounded-sm hover:cursor-pointer mt-6">
    </form>
    <p class="text-xs">By creating an account you agree to be <br> emailed at the adress provided for verification.</p>
    <p class="text-sm">Already have an account? <a href="/signin" class="text-sky-600">Sign In</a> here.</p>
</section>