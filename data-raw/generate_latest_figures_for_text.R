# This script should be run whenever the data it uses changes
# This will save any figures that are to be dynamically added to a YAML file
# When app runs, these figures will be read before the UI code is run, and thus
# available to include in the text.

# Calculating figures for dynamic inclusion
# Access data saved in your data folder just with the name of the .rda file
# For example, we have 'faithful.rda' in the data folder
mean_eruption_minutes <- round(mean(faithful$eruptions), 1)
mean_waiting_minutes <- round(mean(faithful$waiting), 1)

# Saving figures for dynamic inclusion
# Not strictly necessary, as this script can just be rerun as needed, but the
# resulting YAML file could be saved in the GitHub repo - normally there is no
# 'data' folder in repos as the data itself is ignored
yaml::write_yaml(
  list(
    mean_eruption_minutes = mean_eruption_minutes,
    mean_waiting_minutes = mean_waiting_minutes
  ),
  "data/latest_figures.yaml"
)