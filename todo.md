To do:

-   Add lines to the 01-create.R script. I came from the future and identified the rulings that are too big. And add them to the `texts_done` object.

-   What you really need to do is to fix the url for those two missing T rulings. They have a wrong year in the directory. 

-   I could not remove the wrongful attribution of a dissenting opinion in "C-509-09". So the best fix is to make sure that `mp == TRUE` makes so that `av` and `sv` are both `FALSE`. But this sometimes happens... soo... no check.

- Check for interim judges that are not mentioned, like Adriana Guillen and Alexei Julio Estrada. The easiest way to do this, I think, is to get a list of permament judges, and then change the other ones that are not conjuez to interim. 

Exemplar cases:

https://youtu.be/3-8ciBWul5E

-   T-909-11 (Kissing)
-   T-406-92 (Definition: Estado Social de Derecho)
-   C-093-93 (Libertad de cultos)
-   T-140-94 (Tutela, derechos colectivos)
-   C-221-94 (Despenalización de la dosis personal)
-   C-225-95 (DIH, bloque de constitucionalidad)
-   T-036-95 (Dignidad adultos mayores)
-   SU-256-96 (Protección de derechos laborales personas con VIH discriminadas)
-   SU-039-97 (Garantizar consulta previa a comunidades indigenas)
-   C-239-97 (Eutanasia en casos de enfermedades terminales)

[Playground](https://platform.openai.com/playground/prompts?models=gpt-4o)

https://ellmer.tidyverse.org/articles/prompt-design.html