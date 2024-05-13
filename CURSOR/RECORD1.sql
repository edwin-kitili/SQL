DECLARE
  demo_rec gl_sets_of_books%rowtype;
BEGIN
  SELECT * INTO demo_rec 
  FROM gl_sets_of_books 
  WHERE short_name = 'vision University';
  
  -- You can access individual columns like demo_rec.column_name if needed
END;
/
