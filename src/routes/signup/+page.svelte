<script>
    import { connect, db, create_user } from '$lib/session.js';
    import { onMount } from 'svelte';

    onMount(async () => {
        try {
            let success = await connect("", "");
            if (success) {
                const res = await db.info();
                window.location.href = '/listas';
            }
        } catch (err) {
            console.log(err);
        }
    });

    async function crear() {
        let nombre = document.getElementById("nombre").value;
        let apellido = document.getElementById("apellido").value;
        let user = document.getElementById("user").value;
        let email = document.getElementById("email").value;
        let password = document.getElementById("password").value;
        let password_2 = document.getElementById("password_2").value;

        if (nombre == "" || apellido == "" || user == "" || email == "" || password == "" || password_2 == "") {
            alert("Por favor, rellene todos los campos");
        } else if (password != password_2) {
            alert("Las contraseñas no coinciden");
        } else {
            let success = await create_user(user, email, password, nombre, apellido);

            if (!success) {
                alert("Usuario o contraseña incorrectos");
                return;
            }

            try {
                const res = await db.info();
                console.log(res);
                window.location.href = '/listas';
            } catch (err) {
                console.log(err);
                alert("Usuario o contraseña incorrectos");
                //window.location.href = '/login';
            }
        }
    }
</script>

<header class="max-w-lg mx-auto">
    <a href=" ">
        <h1 class="text-6xl font-bold text-white text-center pt-10"><i class="fa-solid fa-cloud"></i></h1>
    </a>
</header>
<main class="bg-[#A0E9FF] max-w-lg mx-auto p-8 md:p-12 my-10 rounded-lg shadow-2xl">
    <section>
        <h3 class="font-bold text-2xl">Bienvenido a ListaKLista</h3>
        <p class="text-gray-600 pt-2">Crea tu Cuenta</p>
    </section>

    <section class="mt-10">
        <div class="flex flex-col" method="POST" action="#">
            <div class="mb-6 pt-3 rounded-lg bg-gray-200">
                <label class="block text-gray-700 text-sm font-bold mb-2 ml-3" for="user">Nombre</label>
                <input type="text" id="nombre" class="bg-gray-200 rounded w-full text-gray-700 focus:outline-none border-b-4 border-gray-300 focus:border-blue-600 transition duration-500 px-3 pb-3">
            </div>
            <div class="mb-6 pt-3 rounded-lg bg-gray-200">
                <label class="block text-gray-700 text-sm font-bold mb-2 ml-3" for="user">Apellido</label>
                <input type="text" id="apellido" class="bg-gray-200 rounded w-full text-gray-700 focus:outline-none border-b-4 border-gray-300 focus:border-blue-600 transition duration-500 px-3 pb-3">
            </div>
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
            <div class="mb-6 pt-3 rounded-lg bg-gray-200">
                <label class="block text-gray-700 text-sm font-bold mb-2 ml-3" for="password">Confirma tu Contraseña</label>
                <input type="password" id="password_2" class="bg-gray-200 rounded w-full text-gray-700 focus:outline-none border-b-4 border-gray-300 focus:border-blue-600 transition duration-500 px-3 pb-3">
            </div>
            <button class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 rounded shadow-lg hover:shadow-xl transition duration-200" on:click={crear}>Crear</button>
        </div>
    </section>
</main>

<div class="max-w-lg mx-auto text-center mt-12 mb-6">
    <p class="text-[#00A9FF]">Ya tienes cuenta? <a href="login" class="font-bold hover:underline text-[#00A9FF]">Log In</a>.</p>
</div>
<footer class="max-w-lg mx-auto flex justify-center text-white">
    <a href="mailto:ListKlista@gmail.com" class="hover:underline text-[#89CFF3]">Contacto</a>
    <span class="mx-3">•</span>
    <a href="https://github.com/danielhtoledo2002/web_project" class="hover:underline text-[#89CFF3]">Proyecto</a>
</footer>