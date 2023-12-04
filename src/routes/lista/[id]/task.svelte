<script>
    import { db } from '$lib/session.js';

    export let tarea;
    let tarea_orig = tarea.completed;

    async function deleteTask() {
        await db.delete(tarea.id);
        window.location.href = '/lista/' + tarea.task_list;
    }

    async function updateCompleted() {
        await db.merge(tarea.id, { completed: tarea.completed });
        tarea_orig = tarea.completed;
        //window.location.href = '/lista/' + tarea.task_list;
    }

    function formatRemaining(rem) {
        let remain = rem.split('m')[0] + 'm';
        remain = remain.replace('m', 'min ');
        remain = remain.replace('h', 'hr ');
        remain = remain.replace('d', 'd ');
        remain = remain.replace('w', 'sem ');
        remain = remain.replace('mo', 'mes ');
        remain = remain.replace('y', 'a ');
        return remain;
    }

    $: if (tarea_orig != tarea.completed) { updateCompleted() };
</script>

<div class={ tarea.completed ? 'line-through opacity-50' : 'opacity-100' }>
    <div class="flex w-full bg-white rounded-xl p-3 flex-col">
        <div class={ tarea.due_date_passed ? 'flex justify-between flex-row text-sm text-red-500' : 'flex justify-between flex-row text-sm text-black' }>
            <div class="flex flex-row">
                <input type="checkbox" bind:checked={tarea.completed} class="mr-2 form-checkbox rounded-full border-gray-300 ">
                <p>{tarea.due_date_passed ? 'Expired' : formatRemaining(tarea.remain) }</p>
            </div>
            <p>{tarea.due_date_format}</p>
        </div>
        <div class="flex flex-row justify-between">
            <div>
                <p class="font-bold">{tarea.name}</p>
            </div>
            <div class="flex flex-row gap-3">
                <button class="hover:opacity-70 fa-solid fa-pen-to-square"></button>
                <button class="hover:opacity-70 fa-solid fa-trash" on:click={deleteTask}></button>
            </div>
        </div>
        <p class="text-sm">Descripción: {tarea.description}</p>
    </div>
</div>
