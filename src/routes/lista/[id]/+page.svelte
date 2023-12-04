<script>
    import { onMount } from 'svelte';
    import { db, connect } from '$lib/session.js';
    import { goto } from '$app/navigation';
    import { page } from '$app/stores'
    import NavBar from '../../navBar.svelte';

    let id = $page.url.pathname.split('/')[2];
    let nombre = "";
    let descripcion = "";
    let tareas = []

    onMount(async () => {
        try {
            let success = await connect("", "");
            if (!success) {
                goto('/login');
            } else {
                let res = await db.select(id);
                let lista = res[0];
                nombre = lista.name;
                descripcion = lista.description;
            }
        } catch (err) {
            console.log(err);
            goto('/login');
        }
    });
</script>

<div>
    <NavBar />
    <div class="flex flex-col justify-start gap-2 p-6">
        <h1 class="text-4xl font-bold">{nombre}</h1>
        <p class="text-sm">{descripcion}</p>
    </div>
</div>