# csd-roa-template

Quarto/Typst [template](./template.pdf) for generating Reports of Analysis for
the NIST Chemical Sciences Division.

## Highlights

- Parameterized reporting.
- User-friendly parameter changing.
- Simple markup language for document formatting.

## Overview

This repo provides a user-friendly template for standardizing Report of Analysis
formatting throughout the Chemical Sciences Division. The framework has been
designed using [Quarto](https://quarto.org), an open-source scientific
publishing system designed for generation of dynamic, reproducible documents to
multiple output formats with embedded code. The skeleton of the report is
produced using [Typst](https://typst.app), a modern, open-source compiler that
produces PDF documents using a simple markup language.

The [Quarto template file](./template.qmd) contains examples of the syntax for
common typesetting needs, such as headings, bold and italics, equations, tables
and figures, cross-references, and references. More information about Quarto
basics can be found
[here](https://quarto.org/docs/authoring/markdown-basics.html). More advanced
features, such as code embedding, includes, and conditional content can be found
throughout the [main guide](https://quarto.org/docs/guide/).

## Contributors

- [Brandon LeBlanc](https://github.com/brandonleblanc1): author
- Christina Cecelski: testing and feedback

## Usage

### Prerequisites

- An installation of the [Quarto CLI](https://quarto.org/docs/get-started/)
  (version 1.9.29 or above) for your system. This can either be downloaded from
  the website or installed from a package manager, such as `winget` or `uv`.
- A text editor (Notepad or similar) or interactive development environment
  (IDE) ([RStudio](https://posit.co/download/rstudio-desktop/), [VS
  Code](https://code.visualstudio.com/download)) of your choice. IDEs are
  recommended for code completion, potential spellchecking, and direct
  integration with Quarto. RStudio has built-in integration with Quarto and is
  very user-friendly. VS Code is much more flexible and customizable, but it has
  a more in-depth installation and setup process before getting it to work
  comfortably. More details can be found on the respective download websites.
  Ultimately, something like Notepad could also be used, but it requires more
  interaction with the command line.

### Project Setup

Project setup will need to happen from a terminal application (command prompt on
Windows). After launching, you will start in your home directory by default, and
the rest of this example assumes you will be creating the template in your home
directory. To create the template in a different directory, such as OneDrive,
make sure you are in that directory first by typing the following and pressing
enter (folders and file names with spaces need to be quoted):

```bash
cd "OneDrive - NIST"
```

To initialize the template for your report, type the following and press enter:

```bash
quarto use template brandonleblanc1/csd-roa-template
```

The Quarto CLI will prompt you to enter a directory name to use the template in.
This directory will now contain the necessary files to use the template. The
template file will be renamed to match the name of the directory you entered.
For example, if you called the directory "MyROA", the template file will be
named "MyROA.qmd". This file can either be opened in Notepad or an IDE for
editing.

Alternatively, a .zip file of the repository can be downloaded, but it is highly
recommended to use the above method to ensure the latest version of the template
is used.

### Editing the Template

The ROA cover sheet has been parametrized using the YAML header at the top of
the Quarto template (the section bracketed by `---`). YAML is a markup language
designed to store metadata in a human-readable format, and Quarto uses it for
specifying and reading document parameters. For each of the fields listed,
simply enter the values that you would like to use to populate the corresponding
entry on the ROA cover sheet. The fields with a value of `false` are optional.
If you would like to use these fields, simply change them to the value you want
to include. Otherwise, leave them as `false`, and they will automatically
populate with "NA".

The body of the document can be edited using the Quarto Markdown language to
include whatever content you like.

### Rendering the Template

If using an IDE, it will probably have a UI to render the document. RStudio has
a render button and render on save option. VS Code has the following option from
the Command Palette (search bar at top): "Quarto: Render Document".

If using something like Notepad to edit, you will need to run the following
command at the terminal (change "MyROA" to whatever you called the directory
during setup):

```bash
quarto render MyROA/MyROA.qmd
```

## Feedback and Discussions

Any feedback is greatly appreciated. Feel free to drop ideas or issues on the
[Discussions](https://github.com/brandonleblanc1/gsmg-coa-template/discussions)
tab or through email.
