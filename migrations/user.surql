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
        FOR create, update WHERE id = $auth.id
        FOR delete NONE
;

DEFINE FIELD id ON user PERMISSIONS 
    FOR create, update, delete NONE
    FOR select FULL
;

-- Define first_name and last_name
DEFINE FIELD first_name ON TABLE user TYPE string;
DEFINE FIELD last_name ON TABLE user TYPE string;


DEFINE FUNCTION fn::is_following($user: record(user)) {
    RETURN (SELECT VALUE count(out) FROM ($auth.id->follow) WHERE out=$user)[0] = 1;
};

-- 1. Solo es accessible para el dueño de la cuenta
-- 2. El email no puede ser nulo y debe ser valido
DEFINE FIELD email ON TABLE user TYPE string
    PERMISSIONS
        FOR select WHERE id = $auth.id
    ASSERT 
        $value != NONE AND string::is::email($value)
;

-- La contraseña puede ser actualizada por el usuario pero no vista
DEFINE FIELD pass ON TABLE user PERMISSIONS FOR select NONE;

