library(testthat)
library(withr)
library(rprojroot)

local_edition(3)


# Instructions ------------------------------------------------------------
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
#    the temporary markdown files (review/temp). You can leave the diff viewer
#    open and revert the changes directly by a simple copy and paste of the
#    original content. Click 'Skip' once the reversions are complete.
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


# Generate snapshots ------------------------------------------------------
# 1. To get the initial snapshot, run the below block, with an expectation for
# each reference file. Use 'Run Tests' button above right.
# You are basically saying "all these files should look as they are now in
# future".
test_that("generate snapshots", {
  with_dir(find_package_root_file(), {
    source("review/scripts/md_to_word.R")
    
    expect_snapshot_file("inst/app/www/assets/markdown/01_mod_the_first.md")
    expect_snapshot_file("inst/app/www/assets/markdown/02_mod_the_second.md")
  })
})

# 2. Comment the above block out now

# 3. Uncomment the below block, ready for future changes


# Compare markdown --------------------------------------------------------
# 4. When you make changes to the files, use 'Run Tests' button above right
# test_that("compare markdown", {
#   with_dir(find_package_root_file(), {
#     source("review/scripts/word_to_md.R")
# 
#     expect_snapshot_file("review/temp/01_mod_the_first.md")
#     expect_snapshot_file("review/temp/02_mod_the_second.md")
#   })
# })


# Run diff viewer ---------------------------------------------------------
# 5. If any differences are present (there should be if you changed the files...)
# a diff viewer can be opened by running the code below in the console (you can 
# open it in browser using the 'Show in new window' button in the Viewer pane)
#     testthat::snapshot_review('snapshot_tests/', "review/tests")


# Review - accept or fix --------------------------------------------------
# 6. Review the changes in each file one by one.
#    If ALL changes in a file are as intended, then choose the 'Accept' option.
#
#    If there are some changes that were not intended, you should fix these in 
#    the source files. You can leave the diff viewer open and revert the changes
#    directly by a simple copy and paste of the original content.
#
#    Click 'Skip' once the reversions are complete.

# 7. Close the diff viewer once only skipped files remain.

# 8. If you had some changes to revert, FIRST MAKE SURE TO COMMENT OUT the line
#        source("review/scripts/word_to_md.R")  
#    then run this test file again with 'Run Tests'. You should expect no
#    differences to be found now, but if there are then repeat step 6 to 8 until
#    none are found.


# Replace markdown --------------------------------------------------------
# 9. It is now safe to copy the revised markdown files from the review/temp folder
#    over the app markdown files in inst/app/www/assets/markdown.
#
#    If you had to comment out the line
#        source("review/scripts/word_to_md.R")
#    due to reversions, MAKE SURE to uncomment it now so it is ready for the next
#    set of changes.
