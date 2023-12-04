DELETE account;

DEFINE SCOPE account SESSION 24h
    SIGNUP (
        CREATE type::thing("user", string::trim($user))
        SET
            email = $email,
            pass = crypto::argon2::generate($pass),
            first_name=$first_name,
            last_name=$last_name
    )
    SIGNIN (
        SELECT * FROM type::thing("user", string::trim($username)) WHERE crypto::argon2::compare(pass, $password)
    )
;

DELETE user;

-- Solo los usuarios pueden modificar su información, pero todos pueden ver.
--
-- Por eso el select tiene FULL permissions y el resto de acciones solo se 
-- pueden realizer si el id de la persona que lo quiere realizar es igual 
-- al del usuario que se quiere modificar
DEFINE TABLE user SCHEMAFULL
    PERMISSIONS
        FOR select FULL
        FOR delete, create, update WHERE id = $auth.id
;

DEFINE FIELD id ON user PERMISSIONS 
    FOR create, update, delete NONE
    FOR select FULL
    TYPE record(user)
;

-- Define first_name and last_name
DEFINE FIELD first_name ON TABLE user TYPE string;
DEFINE FIELD last_name ON TABLE user TYPE string;

-- 1. Solo es accessible para el dueño de la cuenta
-- 2. El email no puede ser nulo y debe ser valido
DEFINE FIELD email ON TABLE user TYPE string
    PERMISSIONS
        FOR select WHERE id = $auth.id
    ASSERT 
        $value != NONE AND string::is::email($value)
;
DEFINE INDEX userEmailIndex ON TABLE user COLUMNS email UNIQUE;

-- La contraseña puede ser actualizada por el usuario pero no vista
DEFINE FIELD pass ON TABLE user PERMISSIONS FOR select NONE TYPE string;


DELETE task_list;

DEFINE TABLE task_list SCHEMAFULL
    PERMISSIONS
        FOR select, create, update, delete WHERE owner = $auth.id
;

DEFINE FIELD id ON TABLE task_list TYPE record(task_list);
DEFINE FIELD owner ON TABLE task_list TYPE record(user) DEFAULT $auth.id;

-- El nombre de la lista no puede ser nulo
DEFINE FIELD name ON TABLE task_list TYPE string ASSERT $value != NONE;
DEFINE FIELD description ON TABLE task_list TYPE string;

-- Cuando se crea un usuario se crea una lista de tareas por defecto llamada "K-List"
DEFINE EVENT create_degaule_task_list ON user WHEN $event = "CREATE" THEN {
    LET $user = $after.id;
    LET $task_list = (CREATE ONLY task_list SET name = "K-Lista", owner = $user, description = "Lista de tareas por defecto");
    RELATE $user->owns->$task_list UNIQUE;
};

DEFINE EVENT relate_created_task_list ON task_list WHEN $event = "CREATE" AND $auth.id = $after.owner THEN {
    LET $user = $after.owner;
    LET $task_list = $after.id;
    RELATE $user->owns->$task_list UNIQUE;
};

DEFINE EVENT delete_lists_from_deleted_user ON user WHEN $event = "DELETE" THEN {
    LET $user = $before.id;
    DELETE $user->owns->task_list;
    DELETE $user->owns;
    DELETE task_list WHERE owner = $user;
};

DELETE owns;

DEFINE TABLE owns SCHEMAFULL
    PERMISSIONS
        FOR create, select, update, delete WHERE out.owner = in
;

DEFINE FIELD id ON TABLE owns TYPE record(owns);
DEFINE FIELD in ON TABLE owns TYPE record(user);
DEFINE FIELD out ON TABLE owns TYPE record(task_list);

DELETE task;

DEFINE TABLE task SCHEMAFULL
    PERMISSIONS
        FOR select, create, update, delete WHERE task_list.owner = $auth.id
;

DEFINE FIELD id ON TABLE task TYPE record(task);
DEFINE FIELD task_list ON TABLE task TYPE record(task_list);
DEFINE FIELD name ON TABLE task TYPE string ASSERT $value != NONE;
DEFINE FIELD description ON TABLE task TYPE string;
DEFINE FIELD due_date ON TABLE task TYPE datetime ASSERT $value != NONE;
DEFINE FIELD completed ON TABLE task TYPE bool DEFAULT false;
DEFINE FIELD due_date_passed ON TABLE task TYPE bool DEFAULT { due_date < time::now() };

DEFINE EVENT relate_created_task ON task WHEN $event = "CREATE" AND $auth.id = $after.task_list.owner THEN {
    LET $task_list = $after.task_list;
    LET $task = $after.id;
    RELATE $task_list->has_task->$task UNIQUE;
};

DEFINE TABLE has_task SCHEMAFULL
    PERMISSIONS
        FOR create, select, update, delete WHERE out.task_list.owner = $auth.id
;

DEFINE FIELD id ON TABLE has_task TYPE record(has_task);
DEFINE FIELD in ON TABLE has_task TYPE record(task_list);
DEFINE FIELD out ON TABLE has_task TYPE record(task);
