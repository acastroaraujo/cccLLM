
# cccLLM

This repository contains code to extract information from court rulings using
LLMs via the new [elmer package](https://elmer.tidyverse.org/).

For using LLMs like ChatGPT you will have to add something like this to your `.Renviron` file:

```
OPENAI_API_KEY = "you_api_goes_here"
```

If you don't know where this file is located, you can use the following function:

```
usethis::edit_r_environ(scope = "user")
```
