if (!rlang::is_attached("package:ellmer")) library(ellmer)

type_summary <- type_object(
  "Resumen detallado de la sentencia. Debe contener los hechos del caso y la decisión tomada por la Corte.",
  spanish = type_string("En español."),
  english = type_string("In English.")
)

type_chamber <- type_string(
  "Nombre de la sala, en caso de que la información sea explícita.",
  required = FALSE
)

type_magistrados <- type_array(
  "Información sobre los magistrados que firmaron la sentencia. El secretario general está excluído de esta lista.",
  items = type_object(
    name = type_string(description = "Nombre."),
    av = type_boolean(description = "Incluye aclaración de voto?"),
    sv = type_boolean(description = "Incluye salvamento de voto?"),
    mp = type_boolean(description = "Es el magistrado ponente?"),
    interim = type_boolean(description = "Es magistrado encargado?"),
    conjuez = type_boolean(description = "Es conjuez?")
  ),
  required = TRUE
)

type_articles <- type_array(
  "Lista de artículos de la Constitución (o \"Carta Política\") que son mencionadas por número en la sentencia de manera explícita. Esta lista excluye otro tipo de articulados, por ejemplo los que son parte de leyes, códigos, decretos, etc.",
  items = type_integer(),
  required = FALSE
)

type_rj <- type_enum(
  "Indica si la decisión se fundamenta en cosa juzgada, es decir, si ya ha sido resuelta previamente por la Corte con efectos vinculantes que impiden que el mismo asunto constitucional sea discutido nuevamente.",
  values = c("sí", "no", "parcial"),
  required = FALSE
)

type_rj_citation <- type_array(
  'Lista de sentencias previas que llevaron a la Corte a decidir que el caso es "cosa juzgada". Las sentencias que no contribuyen a que el caso sea "cosa juzgada" están excluídas de esta lista.',
  items = type_string("Nombre de la sentencia"),
  required = FALSE
)

type_amicus <- type_array(
  'Información sobre intervinientes en calidad de "amicus curiae" en el proceso. Esta lista puede incluir personas naturales, ONGs, asociaciones profesionales, sindicatos, universidades, entidades gubernamentales, y otros tipos de organizaciones públicas o privadas.',
  items = type_object(
    name = type_string(
      "Nombre del interviniente, en caso de que la información sea explícita.",
      required = FALSE
    ),
    affiliation = type_string(
      'Organización a la cual pertenece el interviniente. Si el interviniente no pertence a ninguna organización su afiliación debe ser "persona natural"',
      required = FALSE
    )
  ),
  required = FALSE
)

ruling_summary <- type_object(
  "Información de la sentencia.",
  summary = type_summary,
  chamber_raw = type_chamber,
  person = type_magistrados,
  articles = type_articles,
  rj = type_rj,
  rj_citation_raw = type_rj_citation,
  amicus = type_amicus
)
