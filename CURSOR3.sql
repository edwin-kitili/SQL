DECLARE
c_currency gl_sets_of_books.currency_code%type,
c-suspense gl_sets_of_books.suspense_allowed_flag%type,
c-laston gl_sets_of_books.last_updated_date%type,
c-creation gl_sets_of_books.creation_date%type,
c-creator gl_sets_of_books.created_by%type;
CURSOR c_gl_sets_of_books IS
SELECT currency_code,suspense_allowed_flag,last_updated_date, creation_date,created_by;

BEGIN
OPEN c_gl_sets_of_books
LOOP
FETCH c_gl_sets_of_books into c_currency,c_suspense,c_laston,c_creation,c_creator;
EXIT WHEN c_gl_sets_of_books%NOTFOUND;
END LOOP;
CLOSE c_gl_sets_of_books;
END;
/
