
<script>
    import NavBar from "../navBar.svelte";
    import { onMount } from "svelte";
    import { session, connect, update_user, cerrar_sesion } from "$lib/session.js";
    import { get } from "svelte/store";

    let nombre = "";
    let correo = "";
    let segundo = "";
    
    onMount(async () => {
        await connect("", "");
        try {
            let session_info = get(session);
            nombre = session_info.first_name;
            segundo = session_info.last_name;
            correo = session_info.email;
        } catch (err) {
            console.log(err);
        }
    });

    async function close() {
        await cerrar_sesion();
        window.location.href = "/login";
    }

    async function actualizar() {
        let first_name = document.getElementById("user_1").value;
        let last_name = document.getElementById("user_2").value;
        let email = document.getElementById("email").value;
        let new_pass = document.getElementById("new-password").value;

        let success = await update_user(email, new_pass, first_name, last_name);

        if (!success) {
            alert("Contraseña incorrecta");
            return;
        } else {
            window.location.href = "/user";
        }
    }
</script>

<NavBar nombre={nombre} apellido={segundo}/>
<header class="max-w-lg mx-auto">
    <a href=" ">
        <h1 class="text-6xl font-bold text-white text-center pt-10"><i class="fa-solid fa-cloud"></i></h1>
    </a>
</header>
<main class="bg-[#A0E9FF] max-w-lg mx-auto p-8 md:p-12 my-10 rounded-lg shadow-2xl">
    <section>
        <h3 class="font-bold text-2xl">{nombre} {segundo}</h3>
        <p class="text-gray-600 pt-2">Edita tu Cuenta</p>
    </section>

    <section class="mt-10">
        <div class="flex flex-col">
            <div class="mb-6 pt-3 rounded-lg bg-gray-200">
                <label class="block text-gray-700 text-sm font-bold mb-2 ml-3" for="user">Primer Nombre</label>
                <input type="text" id="user_1" placeholder="{nombre}" class="bg-gray-200 rounded w-full text-gray-700 focus:outline-none border-b-4 border-gray-300 focus:border-blue-600 transition duration-500 px-3 pb-3">
            </div>
            <div class="mb-6 pt-3 rounded-lg bg-gray-200">
                <label class="block text-gray-700 text-sm font-bold mb-2 ml-3" for="user">Segundo Nombre</label>
                <input type="text" id="user_2" placeholder="{segundo}" class="bg-gray-200 rounded w-full text-gray-700 focus:outline-none border-b-4 border-gray-300 focus:border-blue-600 transition duration-500 px-3 pb-3">
            </div>
            <div class="mb-6 pt-3 rounded-lg bg-gray-200">
                <label class="block text-gray-700 text-sm font-bold mb-2 ml-3" for="email">Correo</label>
                <input type="text" id="email" placeholder="{correo}" class="bg-gray-200 rounded w-full text-gray-700 focus:outline-none border-b-4 border-gray-300 focus:border-blue-600 transition duration-500 px-3 pb-3">
            </div>
            <div class="mb-6 pt-3 rounded-lg bg-gray-200">
                <label class="block text-gray-700 text-sm font-bold mb-2 ml-3" for="password">Nueva Contraseña</label>
                <input type="password" id="new-password" class="bg-gray-200 rounded w-full text-gray-700 focus:outline-none border-b-4 border-gray-300 focus:border-blue-600 transition duration-500 px-3 pb-3">
            </div>
          
            <div class="mb-3 pt w-full">
                <button class="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 rounded shadow-lg hover:shadow-xl transition duration-200" on:click={actualizar}>Cambiar</button>
            </div>

            <div class="mb-12 pt w-full">
                <button class="w-full bg-gray-600 hover:bg-gray-700 text-white font-bold py-2 rounded shadow-lg hover:shadow-xl transition duration-200" on:click={close}>Cerrar sesión</button>
            </div>

            <div class="mb-3 pt w-full">
                <button class="w-full bg-red-600 hover:bg-red-700 text-white font-bold py-2 rounded shadow-lg hover:shadow-xl transition duration-200">Eliminar cuenta</button>
            </div>
        </div>
    </section>
</main>

