# cccLLM

This directory contains code to extract information from court rulings using LLMs via the new [ellmer](https://ellmer.tidyverse.org/) package.

For using LLMs like ChatGPT you will have to add something like this to your `.Renviron` file:

```         
OPENAI_API_KEY = "you_api_goes_here"
```

If you don't know where this file is located, you can use the following function:

```         
usethis::edit_r_environ(scope = "user")
```

## Structured Output

The JSON schema I used was constructed using the ellmer package in R.

See [here](https://acastroaraujo.github.io/blog/posts/2025-03-17-llms-for-researchers/#structured-output) for more information on the "structured output" capabilities of some LLMs.

You can find both the system prompt and JSON schema in the `prompts` directory.

## Manual Coding of Very Large Files

Some documents exceed the maximum context length of 128000 tokens. This happens, for example, when a lengthy appendix is included in the file. This means I couldn't parse them in the same ways as the others.

These documents were manually coded, with the exception of the English and Spanish summaries which were written using the file upload option in the OpenAI platform.

They can be found in the `out_raw_exceeded` directory.

*Working with the document embeddings provided by OpenAI's RAG system produce very unreliable results.* There is a higher chance that the somes fields here — e.g., `articles` and `amicus` — are miscoded. I've tried my best to keep things reliable via manual inspection! This is why there is a `model` variable in the codebook that distinguishes between "gpt-4o" and "acastroaraujo".

I recommend you double-check these rulings if you are going to analyze the `articles` variable.

## Misc.

The `amicus` field contains information about participants acting as amicus curiae ("friends of the court") in the corresponding ruling. The output may include individual people, NGOs, professional associations, labor unions, universities, government entities, and other types of public or private organizations.

There is one inconsistency in how the Office of The Inspector General ("Procuraduría General de La Nación") is coded in this field. Since it is mandatory for each `C` ruling to contain the input of this office (see article 242 of the Colombian Constitution), this intervention is sometimes separated from the interventions of other third parties. Thus, this government agency shows up in the `amicus` field in an inconsistent fashion. The best way to treat this issue is to remove this office from all `amicus` fields in all `C` rulings. That's exactly what I did.

## Extra

I build the permanent judges dataset based on a host of scattered resources. It's surprising that there's no easily accessible dataset containing this information.

- [La Corte Constitucional y sus Magistrados — William Guillermo Jiménez](https://repository.unilibre.edu.co/bitstream/handle/10901/19670/Corte%20Constitucional%20y%20sus%20magistrados%20vr.%20digital%20(1).pdf)

- [This government website](https://www.ramajudicial.gov.co/web/corte-constitucional/portal/corporacion/magistrados/magistrados-anteriores)

- (Strategic Prudence in the Colombian Constitutional Court, 1992-2006)[https://d-scholarship.pitt.edu/8953/1/Rodriguez-Raga_Juan_Carlos_Dissertation_07_2011.pdf]

This is the best source I found: https://cej.org.co/eleccion-transparente/200-corte-constitucional?start=2