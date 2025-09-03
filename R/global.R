# A global.R is the cleanest way of loading in some data before the UI is run
# Replace the package argument with name of your package
latest_figures <- yaml::read_yaml(
  system.file("extdata", "latest_figures.yaml", package = "nhsbsaShinyR")
)
