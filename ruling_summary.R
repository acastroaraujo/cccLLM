
if (!rlang::is_attached("ellmer")) library(ellmer)

ruling_summary <- type_object(
  "Información de la sentencia.",
  summary = type_object(
    'Resumen detallado de la sentencia. Debe contener los hechos del caso y la decisión tomada por la corte.',
    es = type_string("En español."), 
    en = type_string("Traducido al inglés.")
  ),
  chamber_raw = type_string(
    'Nombre de la sala, en caso de que la información sea explicíta.', required = FALSE),
  person = type_array(
    '- Lista de nombres de los magistrados que firmaron la sentencia. 
    
    - Excluir al secretario general de esta lista.
    
    - Las salas de revisión usualmente tienen 3 magistrados, mientras que la sala plena usualmente tiene 9 magistrados.
    
    - Algunas decisiones incluyen salvamentos o aclaraciones de voto. En estos casos esta información aparece al final del documento.
    ',
    items = type_object(
      name = type_string(description = "Nombre."), 
      av = type_boolean(description = "Incluye aclaración de voto?"),
      sv = type_boolean(description = "Incluye salvamento de voto?"),
      conjuez = type_boolean(description = "Es conjuez?"),
      mp = type_boolean(description = "Es el magistrado ponente?")
    ),
    required = TRUE
  ),
  articles = type_array(
    "Lista de artículos de la Constitución que son objeto de discusión, en caso de que la información sea explícita. Excluir otros tipos de artículo.", 
    items = type_integer(), required = FALSE
  ),
  rj = type_boolean("La corte decide que el caso es \"cosa juzgada\"?", required = FALSE),
  rj_citation_raw = type_array("Lista de sentencias previas que llevaron a la corte a decidir que el caso era \"cosa juzgada\". Sólo responder si la información es explícita. Excluir las sentencias que no llevan a que el caso sea \"cosa juzgada\"", items = type_string(), required = FALSE)
)



