DEFINE SCOPE account SESSION 24h
    SIGNUP (
        CREATE type::thing("user", string::trim($user))
        SET
            email = $email,
            pass = crypto::argon2::generate($pass),
            first_name="",
            last_name=""
    )
    SIGNIN (
        SELECT * FROM user WHERE email = $email AND pass = crypto::argon2::verify($pass, pass)
    )
;