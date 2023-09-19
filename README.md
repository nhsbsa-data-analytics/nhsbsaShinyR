# NHSBSA R Shiny template

This R package has been developed by NHS Business Services Authority Data Analytics Learning Lab to use as a template for building NHSBSA branded R `{shiny}` dashboards. 

## Features

We have used the `{golem}` framework to develop this taking inspiration from:

* [Example `golem` apps](https://github.com/ThinkR-open/golem)
* [Clinical Development Unit Data Science Team dashboards](https://github.com/CDU-data-science-team)

It includes several dummy modules demonstrating using markdown, scrollytell and `{highcharter}` with an NHSBSA theme applied. 

Also included is a sample `data-raw/` script. Much of the data used in NHSBSA dashboards can be sensitive, so the `data/` directory in most cases should be included in the `.gitignore` in the initial commit of your new repo (`usethis::use_git_ignore("data")`).

There are also github actions to check that code conforms to `lintr` (https://lintr.r-lib.org/), passes `R CMD check` and to run a `gitleaks` check.

## Structure

The package is structured as below. See the "Using this template" section for further details of the files.

```
nhsbsaShinyR
├── .git                                    # Git folder, should never need to even look in here!
├── .github                                 # Workflows for github actions - lintr and R CMD check
├── .gitignore                              # Ensure that you ignore the data folder once template is reused
├── .Rbuildignore                           # Like a .gitignore, add any files to ignore when building the package
├── app.R                                   # Golem file
├── data                                    # Package data (accessible via nhsbsaShinyR::{name})
├── data-raw                                # Example script to produce a package data file
├── DESCRIPTION                             # Metadata of package
├── dev                                     # Golem files
│   ├── 01_start.R                          # Golem file (use to set up golem framework)
│   ├── 02_dev.R                            # Golem file (use to develop package)
│   ├── 03_deploy.R                         # Golem file (use to deploy package)
│   └── run_dev.R                           # Golem file (use to test development of package)
├── gitleaks.toml                           # Config for gitleaks, only needed in public repos (see DALL wiki)
├── inst                                    # Installed files...
│   ├── app                                 # For the app...
│   │   └── www                             # Made available at runtime
│   │       └── assets                      # Static files
|   |           ├── favicons                # NHS favicons
|   |           ├── icons                   # NHS front-end toolkit icons
|   |           ├── logos                   # NHS logos
|   |           └── markdown                # Markdown documents
│   │       ├── css                         # NHS front-end toolkit and custom CSS
│   │       └── js                          # NHS front-end toolkit and custom JavaScript
│   └── golem-config.yml                    # Golem file
├── LICENSE.md                              # Apache
├── man                                     # Package documentation, created automatically by roxygen2 from your initial comment blocks
├── NAMESPACE                               # Automatically generated documentation by roxygen2
├── nhsbsaShinyR.Rproj                      # R Project file
├── R                                       # R code for the dashboard
│   ├── _disable_autoload.R                 # Golem file (no modification)
│   ├── app_config.R                        # Golem file
│   ├── app_server.R                        # Server component
│   ├── app_ui.R                            # UI component
│   ├── golem_utils_ui.R                    # Useful utility functions for UI
│   ├── mod_*.R                             # Example Shiny modules
|   ├── nhs_*.R                             # NHS styled UI components
|   ├── nhsbsaShinyR.R                      # Package documentation file
│   ├── run_app.R                           # Golem file (no modification)
│   ├── utils_accessibility.R               # Custom NHSBSA highcharter theme
│   └── utils-pipe.R                        # Magrittr %>% operator
└── README.md                               # Brief overview of the package

```

## Using this template

### Creating a new repository

Open the [new repository page on GitHub](https://github.com/organizations/nhsbsa-data-analytics/repositories/new).

Under "Repository template" select "nhsbsa-data-analytics/nhsbsaShinyR".

Enter a new name and a brief description.

Leave it set as a Private repo for now. Later, when you are finished, consider if you are able to make it public.

### Renaming the golem app

Once you copy this repository, please change `nhsbsaShinyR` to new package name you give. Use Ctrl+Shift+F in Rstudio to search for `nhsbsaShinyR`, then replace all occurrences. You should also rename the `nhsbsaShinyR.Rproj` file to `{your_package}.Rproj`. You could try using `golem::set_golem_name("your_package")`, but there may still be some changes to be made. Another file to rename would be `R/nhsbsaShinyR.R`

### `.github/workflows/gitleaks.yaml`

Follow the [instructions on the wiki](https://nhsbsauk.sharepoint.com/sites/InsightTeam-DataAnalyticsLearningLabDALL/_layouts/15/Doc.aspx?sourcedoc={e0ee8ea3-87db-4464-9184-8a19407544f4}&action=edit&wd=target%28Coding%20and%20Dashboards%2FGitHub.one%7C6debe185-aaac-4abb-bc30-ba2445e928b0%2FGitleaks%7C875605f5-06dd-45af-8378-a270364bd12e%2F%29&wdorigin=NavigationUrl) to create a repository secret. If your repo becomes public, delete this workflow file and the repository secret if it has been set.

### `.gitignore`

Ensure that you ignore the data folder once template is reused. Best to do this at beginning and then can consider allowing some or all of the data to be added depending on its source and sensitivity.

### `.Rbuildignore`

Like a .gitignore, add any files to ignore when building the package. If there is anything that should be ignored when building, R CMD check will pick it up. You can either manually add to the file or use `usethis::use_build_ignore("ignore.me")`.

### `app.R`

Will need the package name replaced. Use this to deploy to shinyapps.io by clicking Publish button in RStudio.

### `data` folder

Any package data you add with `usethis::use_data` will be saved here as an .rda file. In your app, access these data with `your_pkg_name::your_data`. BE CAREFUL about exposing sensitive data! See notes for `.gitignore`.

Remember, data should also be documented! Do this in the `R` folder.

### `data-raw` folder

Any package data you create should have an accompanying script in this folder. The last step should be to save it with `usethis::use_data`.

### `DESCRIPTION`

This is an essential file for an R package, containing various metadata.

* `Package:` - Replace `nhsbsaShinyR` with your package name.
* `Title:` - Single line in sentence-case, no period.
* `Version:` - Replace this with `0.0.0.9000` on first commit, and remember to bump it up every time you add a commit to main. Use the function `usethis::use_version()` to increment it. This is not so important when developing, but once finished it is essential to bump versions if something changes, so that anyone who has installed the package can see there is a new version.
* `Authors@R:` - Use the DALL entry for contact purposes. All other people contributing should be specified with `role = "ctb"`.
* `Description:` - Add a short description of your app. Must be a minimum of one sentence with a period.
* `License:` - Should not need to change, but if you do want a different license look at `usethis::use_*_license` functions. Delete the existing license and this field before using one of those.
* `Depends:` - Set the minimum version of R that the package can be installed on. Be careful not to be over-restrictive. Using the first major version of your current installation should be adequate, for example 4.0 as is currently set..
* `Imports:`  - Any package used in code in the `R` folder and the `app.R` file should be included in this.
* `Suggests:` - Any package used only outside the `R` folder or `app.R` file should be included in this.  
* `Remotes:` - Add any GitHub repos you have installed packages from, that you use in the app.
* `Encoding:` - UTF-8 is recommended, no need to change this.
* `LazyData:` - This sets any package data to be read lazily, no need to change.
* `RoxygenNote:` - This will be set automatically when `roxygen2` creates documentation. Ensure you have the latest version of `roxygen2`.

### `dev` folder

The main file here is `run_dev.R`. This will be useful when developing, as you can make a change, then run this. The package will be loaded and re-documented.

The other files are useful to get to know what golem and usethis can do, so have an experiment with them!

### `gitleaks.toml`

This has the config we use for `gitleaks`. It can be safely deleted from your new repo, as the workflows access it only in this template repo.

### 'inst' folder

The `golem-config.yml` file will need to have the `golem_name` field set to your package name.

The `app/www` folder contains sub-folders for static assets and CSS and JavaScript files. Add any custom CSS to `css/style.css` and custom JavaScript to `js/custom.js`.

### LICENSE.md

Set as Apache PL v2. Can remove this and the `LICENSE` field in `DESCRIPTION` if you want to use another license, using one of the license functions in `usethis`.

### `man`

Don't ever modify these, `roxygen2` will take care of these for you. If you want to amend the documentation for anything, do it in the roxygen block at the top of a function.

### `NAMESPACE`

Don't ever modify this, `roxygen2` will take care of this for you. To import a package, make sure it is added to the `Imports` field of `DESCRIPTION`. You should be namespacing any functions you use that are not in the `base` package, with the package added to `DESCRIPTION` `Imports`. If you need to add something that is not suited to namespacing, e.g. `rlang` `:=` and `.data` operators, add it to the package documentation file in `R/your_package_name.R`, like `@importFrom rlang := .data`.

### `nhsbsaShinyR.Rproj`

RStudio R project file, should be renamed to your package name.

### `R`

All code that is used internally and/or is to be exported from the package belongs in here. Ensure functions that are exported are documented. Add `@export` to the roxygen block of a function to export it. Add `noRd` to the roxygen block for any internal only functions.

### `README.md`

Give an overview of your package including how to install and the simplest example of usage.

