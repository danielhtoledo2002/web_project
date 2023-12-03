
<script>
    import NavBar from "../navBar.svelte";
</script>

<NavBar/>
<header class="max-w-lg mx-auto">
    <a href=" ">
        <h1 class="text-6xl font-bold text-white text-center pt-10"><i class="fa-solid fa-cloud"></i></h1>
    </a>
</header>
<main class="bg-[#A0E9FF] max-w-lg mx-auto p-8 md:p-12 my-10 rounded-lg shadow-2xl">
    <section>
        <h3 class="font-bold text-2xl">NOMBRE USUARIO</h3>
        <p class="text-gray-600 pt-2">Edita tu Cuenta</p>
    </section>

    <section class="mt-10">
        <form class="flex flex-col" method="POST" action="#">
            <div class="mb-6 pt-3 rounded-lg bg-gray-200">
                <label class="block text-gray-700 text-sm font-bold mb-2 ml-3" for="user">Usuario</label>
                <input type="text" id="user" class="bg-gray-200 rounded w-full text-gray-700 focus:outline-none border-b-4 border-gray-300 focus:border-blue-600 transition duration-500 px-3 pb-3">
            </div>
            <div class="mb-6 pt-3 rounded-lg bg-gray-200">
                <label class="block text-gray-700 text-sm font-bold mb-2 ml-3" for="email">Correo</label>
                <input type="text" id="email" class="bg-gray-200 rounded w-full text-gray-700 focus:outline-none border-b-4 border-gray-300 focus:border-blue-600 transition duration-500 px-3 pb-3">
            </div>
            <div class="mb-6 pt-3 rounded-lg bg-gray-200">
                <label class="block text-gray-700 text-sm font-bold mb-2 ml-3" for="password">Contraseña</label>
                <input type="password" id="password" class="bg-gray-200 rounded w-full text-gray-700 focus:outline-none border-b-4 border-gray-300 focus:border-blue-600 transition duration-500 px-3 pb-3">
            </div>
          
            <button class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 rounded shadow-lg hover:shadow-xl transition duration-200" type="submit">Cambiar</button>
        </form>
    </section>
</main>

