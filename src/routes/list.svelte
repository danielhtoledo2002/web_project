<script>
    import { db } from '$lib/session.js';

    export let id = "";
    export let descripcion = "";
    export let nombre = "";

   async function deleteList() {
        await db.delete(id);
        window.location.href = '/listas';
    }
</script>

<div class="flex p-5 bg-[#A0E9FF] rounded-lg text-white-400  space-x-1 justify-center group">
    <div class="flex flex-col items-center gap-2">
        <p class="text-opacity-50 font-bold text-black space-x-5 ">{nombre}</p>
        <div class="hidden flex space-x-5 flex-row group-hover:block">
            <i class="fa-solid fa-pen-to-square"></i>
            <button class="hover:opacity-70 fa-solid fa-trash" on:click={deleteList}></button>
            <i class="fa-solid fa-play"></i>
        </div>
    </div>
</div>