<script>
    import { onMount } from 'svelte';
    import NavBar from '../navBar.svelte';
    import { connect, session, db } from '$lib/session.js';
    import { get } from 'svelte/store';
    import List from '../list.svelte';
    import CreateList from '../createList.svelte';
    import EditLista from '../editlista.svelte';

    let nombre = "";
    let apellido = "";
    let listas = [];
    let creating = false;
    let editing = false;

    let editing_id = "";
    let editing_nombre = "";
    let editing_descripcion = "";

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

            document.onkeyup = function(e) {
                // Set creating to false if the user presses the escape key
                if (e.key === "Escape") {
                    creating = false;
                }
            }
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
    <div class="flex flex-row grow">
        <NavBar nombre={nombre} apellido={apellido}/>
    </div>

    <div class="relative">
        <div class={ creating || editing ? 'blur-sm' : '' }>
            <div class="p-9">
                <button 
                    on:click={createList}
                    class="p-6 h-12 rounded-lg bg-slate-100 hover:bg-slate-200 flex flex-row w-64 space-x-5 justify-items-center content-center justify-center items-center"
                >
                    <div>
                        <i class="fa-solid fa-plus"></i>
                    </div>
                    <div>
                        Crear Lista
                    </div>
                
                </button>
            </div>
    
            <div class=" grid grid-cols-4  flew-wrape  justify-center gap-4 p-6">
    
                <!-- Instace of Lista for each json object in listas passing nombre and id -->
                {#each listas as lista}
                    <List 
                        nombre={lista.name} 
                        id={lista.id} 
                        descripcion={lista.description}
                        bind:editing={editing}
                        bind:editing_id={editing_id}
                        bind:editing_nombre={editing_nombre}
                        bind:editing_descripcion={editing_descripcion}
                    />
                {/each}
    
            </div>
        </div>
        
        
        {#if creating}
        <div class="absolute inset-0 z-10">
            <CreateList bind:creating={creating}/>
        </div>
        {/if}

        {#if editing}
        <div class="absolute inset-0 z-10">
            <EditLista 
            bind:editing={editing}
            bind:id={editing_id}
            bind:nombre={editing_nombre}
            bind:descripcion={editing_descripcion}
            />
        </div>
        {/if}
        
    </div>
</div>


