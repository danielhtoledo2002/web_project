<script>
    import { onMount } from 'svelte';
    import NavBar from '../navBar.svelte';
    import { connect, session, db } from '$lib/session.js';
    import { get } from 'svelte/store';
    import List from '../list.svelte';

    let nombre = "";
    let apellido = "";
    let listas = [];

    onMount(async () => {
        try {
            let success = await connect("", "");
            if (!success) {
                window.location.href = '/login';
            }

            let session_info = get(session);
            nombre = session_info.first_name;
            apellido = session_info.last_name;

            let listas_usuario = await db.query('SELECT * FROM $auth.id->owns->task_list');
            listas = listas_usuario[0]; 
        } catch (err) {
            console.log(err);
            window.location.href = '/login';
        }


    });
 
</script>

<div class=" flex flex-row grow">
    <NavBar nombre={nombre} apellido={apellido}/>
</div>


<div class="p-9 font-semibold tracking-tight ml-2">
    <h1>Bienvenido</h1>
</div>

<div class="p-9">
    <div class=" p-6  h-12 rounded-lg bg-slate-100 flex flex-row w-64 space-x-5 justify-items-center content-center justify-center items-center">
        <div>
            <i class="fa-solid fa-plus"></i>
        </div>
        <div>
            Create Task
        </div>
    
    </div>
</div>

<div class=" grid grid-cols-4  flew-wrape  justify-center gap-4 p-6">

    <!-- Instace of Lista for each json object in listas passing nombre and id -->
    {#each listas as lista}
        <List nombre={lista.name} id={lista.id} descripcion={listas.description}/>
    {/each}

</div>
