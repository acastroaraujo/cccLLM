
ruling_summary <- elmer::type_object(
  "Información de la sentencia.",
  person = elmer::type_array(
    '- Lista de nombres de los magistrados que firmaron la sentencia. 
    
    - Excluir al secretario general de esta lista.
    
    - Las salas de revisión usualmente tienen 3 magistrados, mientras que la sala plena usualmente tiene 9 magistrados.
    
    - Algunas decisiones incluyen salvamentos o aclaraciones de voto. En estos casos esta información aparece al final del documento.
    ',
    items = elmer::type_object(
      name = elmer::type_string(description = "Nombre."), 
      av = elmer::type_boolean(description = "Incluye aclaración de voto?", required = FALSE),
      sv = elmer::type_boolean(description = "Incluye salvamento de voto?", required = FALSE),
      conjuez = elmer::type_boolean(description = "Es conjuez?", required = FALSE),
      mp = elmer::type_boolean(description = "Es el magistrado ponente?", required = FALSE)
    ),
    required = TRUE
  ),
  chamber = elmer::type_string(
    'Nombre de la sala, en caso de que la información sea explicíta.', 
    required = FALSE),
  summary = elmer::type_object(
    'Resumen detallado de la sentencia. Debe contener los hechos del caso y la decisión tomada por la corte.',
    en = elmer::type_string("En español."), 
    es = elmer::type_string("Traducido al inglés.")
  )
)
