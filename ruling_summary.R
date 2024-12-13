
library(elmer)

ruling_summary <- type_object(
  "Información de la sentencia.",
  person = type_array(
    '- Lista de nombres de los magistrados que firmaron la sentencia. 
    
    - Excluir al secretario general de esta lista.
    
    - Las salas de revisión usualmente tienen 3 magistrados, mientras que la sala plena usualmente tiene 9 magistrados.
    
    - Algunas decisiones incluyen salvamentos o aclaraciones de voto. En estos casos esta información aparece al final del documento.
    ',
    items = type_object(
      name = type_string(description = "Nombre."), 
      av = type_boolean(description = "Incluye aclaración de voto?", required = FALSE),
      sv = type_boolean(description = "Incluye salvamento de voto?", required = FALSE),
      conjuez = type_boolean(description = "Es conjuez?", required = FALSE),
      mp = type_boolean(description = "Es el magistrado ponente?", required = FALSE)
    ),
    required = TRUE
  ),
  chamber = type_string(
    'Nombre de la sala, en caso de que la información sea explicíta.', 
    required = FALSE),
  summary = type_object(
    'Resumen detallado de la sentencia. Debe contener los hechos del caso y la decisión tomada por la corte.',
    es = type_string("En español."), 
    en = type_string("Traducido al inglés.")
  )
)
