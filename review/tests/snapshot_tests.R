library(testthat)
library(withr)
library(rprojroot)

local_edition(3)

# INSTRUCTIONS
# 1. Get initial snapshots
# 2. Comment out the first code block
# 3. Uncomment the rest of the code
# 4. Whenever you make changes to these files, 'Run Tests' again
# 5. Any differences will be caught; run the below code in the console to review
#    them in a shiny app (working dir is project root):
#        testthat::snapshot_review('snapshot_tests/', "review/tests")
# 6. Review the changes in each file one by one.
#    If ALL changes in a file are as intended, then choose the 'Accept' option.
#    If there are some changes that were not intended, you should fix these in 
#    the source files. You can leave the diff viewer open and revert the changes
#    directly by a simple copy and paste of the original content. Click 'Skip' 
#    once the reversions are complete.
# 7. Close the diff viewer once only skipped files remain.
# 8. If you had some changes to revert, FIRST MAKE SURE TO COMMENT OUT the line
#        source("review/scripts/word_to_md.R")  
#    then run this test file again with 'Run Tests'. You should expect no
#    differences to be found now, but if there are then repeat step 6 to 8 until
#    none are found.
# 9. If you had to comment out the line
#        source("review/scripts/word_to_md.R")
#    due to reversions, uncomment it now so it is ready for the next set of 
#    changes.

# 1. To get the initial snapshot, run the below block, with an expectation for
# each reference file. Use 'Run Tests' button above right.
# You are basically saying "all these files should look as they are now in
# future".
test_that("generate snapshots", {
  with_dir(find_package_root_file(), {
    expect_snapshot_file("inst/markdown/01_headline_figures.md")
    expect_snapshot_file("inst/markdown/02_patients_age_gender.md")
    expect_snapshot_file("inst/markdown/03_patients_imd.md")
    expect_snapshot_file("inst/markdown/04_metrics_ch_type.md")
    expect_snapshot_file("inst/markdown/05_metrics_age_gender.md")
    expect_snapshot_file("inst/markdown/06_geo_ch_flag.md")
    expect_snapshot_file("inst/markdown/07_ch_flag_drug.md")
    expect_snapshot_file("inst/markdown/08_geo_ch_flag_drug.md")
    expect_snapshot_file("inst/markdown/09_metrics_1.md")
    expect_snapshot_file("inst/markdown/09_metrics_2.md")
    expect_snapshot_file("inst/markdown/09_metrics_3.md")
    expect_snapshot_file("inst/markdown/09_metrics_4.md")
    expect_snapshot_file("inst/markdown/10_datasets.md")
    expect_snapshot_file("inst/markdown/11_address_matching.md")
    expect_snapshot_file("inst/markdown/12_feedback.md")
    expect_snapshot_file("inst/markdown/13_annex.md")
    expect_snapshot_file("inst/markdown/final_thoughts.md")
  })
})

# 2. Comment the above block out now

# 3. Uncomment the below block, ready for future changes

# 4. When you make changes to the files, use 'Run Tests' button above right
# test_that("markdown text is as expected", {
#   with_dir(find_package_root_file(), {
#     source("review/scripts/word_to_md.R")
# 
#     expect_snapshot_file("review/temp/01_headline_figures.md")
#     expect_snapshot_file("review/temp/02_patients_age_gender.md")
#     expect_snapshot_file("review/temp/03_patients_imd.md")
#     expect_snapshot_file("review/temp/04_metrics_ch_type.md")
#     expect_snapshot_file("review/temp/05_metrics_age_gender.md")
#     expect_snapshot_file("review/temp/06_geo_ch_flag.md")
#     expect_snapshot_file("review/temp/07_ch_flag_drug.md")
#     expect_snapshot_file("review/temp/08_geo_ch_flag_drug.md")
#     expect_snapshot_file("review/temp/09_metrics_1.md")
#     expect_snapshot_file("review/temp/09_metrics_2.md")
#     expect_snapshot_file("review/temp/09_metrics_3.md")
#     expect_snapshot_file("review/temp/09_metrics_4.md")
#     expect_snapshot_file("review/temp/10_datasets.md")
#     expect_snapshot_file("review/temp/11_address_matching.md")
#     expect_snapshot_file("review/temp/12_feedback.md")
#     expect_snapshot_file("review/temp/13_annex.md")
#     expect_snapshot_file("review/temp/final_thoughts.md")
#   })
# })

# 5. If any differences are present (there should be if you changed the
# files...) a shiny app can be started showing the differences by running the
# code below in the console (you can open it in browser using the 'Show in new
# window' button in the Viewer pane)
#     testthat::snapshot_review('snapshot_tests/', "review/tests")

# 6. Review the changes in each file one by one.
#    If ALL changes in a file are as intended, then choose the 'Accept' option.
#    If there are some changes that were not intended, you should fix these in 
#    the source files. You can leave the diff viewer open and revert the changes
#    directly by a simple copy and paste of the original content. Click 'Skip' 
#    once the reversions are complete.

# 7. Close the diff viewer once only skipped files remain.

# 8. If you had some changes to revert, FIRST MAKE SURE TO COMMENT OUT the line
#        source("review/scripts/word_to_md.R")  
#    then run this test file again with 'Run Tests'. You should expect no
#    differences to be found now, but if there are then repeat step 6 to 8 until
#    none are found.

# 9. If you had to comment out the line
#        source("review/scripts/word_to_md.R")
#    due to reversions, uncomment it now so it is ready for the next set of 
#    changes.
