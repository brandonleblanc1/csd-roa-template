# csd-roa-template

Quarto/Typst [template](./template.pdf) for generating Reports of Analysis for the NIST Chemical Sciences Division.

## Highlights
- Parameterized reporting.
- User-friendly parameter changing.
- Simple markup language for document formatting.

## Overview

This repo provides a user-friendly template for standardizing Report of Analysis formatting throughout the Chemical Sciences Division. The framework has been designed using [Quarto](https://quarto.org), an open-source scientific publishing system designed for generation of dynamic, reproducible documents to multiple output formats with embedded code. The skeleton of the report is produced using [Typst](https://typst.app), a modern, open-source compiler that produces PDF documents using a simple markup language.

The [Quarto template file](./template.qmd) contains examples of the syntax for common typesetting needs, such as headings, bold and italics, equations, tables and figures, cross-references, and references. More information about Quarto basics can be found [here](https://quarto.org/docs/authoring/markdown-basics.html). More advanced features, such as code embedding, includes, and conditional content can be found throughout the [main guide](https://quarto.org/docs/guide/).

## Contributors

- [Brandon LeBlanc](https://github.com/brandonleblanc1): author

## Usage

### Prerequisites

- An installation of the [Quarto CLI](https://quarto.org/docs/get-started/) (version 1.9.29 or above) for your system.
- A text editor (Notepad or similar) or IDE ([RStudio](https://posit.co/download/rstudio-desktop/), [VS Code](https://code.visualstudio.com/download)) of your choice. IDEs are recommended for code completion, potential spellchecking, and direct integration with Quarto. RStudio has the benefit of built-in integration with Quarto and is very user-friendly; however, it also requires a current R installation. Details can be found on the download website. VS Code is much more flexible and customizable, but it has a more in-depth installation and setup process before getting it to work comfortably. Ultimately, something like Notepad could also be used, but you must be comfortable using the command-line interface.

### Project Setup

From a terminal (command prompt on Windows), type the following and press enter:

```bash
quarto use template brandonleblanc1/csd-roa-template
```

The Quarto CLI will prompt you to enter a directory name to use the template in. This directory will now contain the necessary files to use the template.

### Editing and Rendering the Template

The template file will be renamed to match the name of the directory entered. For example, if you called the directory "MyROA", the template file will be named "MyROA.qmd". This file can either be opened in Notepad or an IDE for editing.

If using an IDE, it will probably have a UI to render the document. RStudio has a render button and render on save option. VS Code has the following option from the Command Palette (search bar at top): "Quarto: Render Document".

I using something like Notepad to edit, you will need to run the following command at the terminal:

```bash
quarto render path/to/MyROA/MyROA.qmd
```

## Feedback and Discussions
Any feedback is greatly appreciated. Feel free to drop ideas or issues on the [Discussions](https://github.com/brandonleblanc1/gsmg-coa-template/discussions) tab or through email.