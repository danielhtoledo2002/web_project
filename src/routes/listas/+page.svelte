<script>
    import { onMount } from 'svelte';
    import NavBar from '../navBar.svelte';
    import { connect, session, db } from '$lib/session.js';
    import { get } from 'svelte/store';
    import List from '../list.svelte';
    import CreateList from '../createList.svelte';

    let nombre = "";
    let apellido = "";
    let listas = [];
    let creating = false;

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

    function createList() {
        creating = !creating;
    }
</script>

<div>
    <div class=" flex flex-row grow">
        <NavBar nombre={nombre} apellido={apellido}/>
    </div>

    <div class="p-9">
        <button 
            on:click={createList}
            class="p-6 h-12 rounded-lg bg-slate-100 hover:bg-slate-200 flex flex-row w-64 space-x-5 justify-items-center content-center justify-center items-center"
        >
            <div>
                <i class="fa-solid fa-plus"></i>
            </div>
            <div>
                Create Task
            </div>
        
        </button>
    </div>

    <div class=" grid grid-cols-4  flew-wrape  justify-center gap-4 p-6">

        <!-- Instace of Lista for each json object in listas passing nombre and id -->
        {#each listas as lista}
            <List nombre={lista.name} id={lista.id} descripcion={listas.description}/>
        {/each}

    </div>
</div>

{#if creating}
    <CreateList />
{/if}
