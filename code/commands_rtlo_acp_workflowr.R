# code to run workflowr project as per: https://workflowr.github.io/workflowr/articles/wflow-09-workshop.html

# call package
library(workflowr)

# if needed, setup connect to GitHub/GitLab account, only needs to be run one time
#wflow_git_config(user.name = "Daniel Rizzolo", user.email = "djrizzolo@alaska.edu")

# start workflowr project, which creates the default directory structure required by the package
#wflow_start("[Root Directory path]ADD PROJECT NAME = will be name of GitHub repository, too")

# open RMarkdown files ####
wflow_open("analysis/plot_obs_no_species_id.Rmd")

# run/knit RMarkdown file ####
# update ancillary docs
wflow_build("analysis/about.Rmd")
wflow_build("analysis/index.Rmd")
wflow_build("analysis/license.Rmd")

# update summary docs
wflow_build("analysis/plot_obs_no_species_id.Rmd")


# or view previous run of the code with ####
#wflow_view("docs/plot_obs_no_species_id.Rmd")
#wflow_view("docs/about.Rmd")
#wflow_view("docs/index.Rm")
#wflow_view("docs/license.Rmd")

# check status of files to see if they have been committed to Git and pushed to the online repository (status of both will check Rmd and data files) ####
wflow_status()

# commit this version of the code in the RMarkdown file to Git. Workflowr uses the term "publish" for commit ####
# publish/commit files individually to have file-specific commit comments
# publishing/committing re-runs the Rmd files

wflow_publish("analysis/about.Rmd", "initial commit")
wflow_publish("analysis/index.Rmd", "initial commit")
wflow_publish("analysis/license.Rmd", "initial commit")

wflow_publish("analysis/plot_obs_no_species_id.Rmd", "")

# push files to GitHub, including html project file that can be viewed online, Note: follow prompts in R Console window ####

# check connection to GitHub repository to be sure it is correct ####

wflow_use_github("DJRIZZ")

# test run of push ####
wflow_git_push(dry_run = TRUE)
# results in console message"
# Pushing to the branch "main" of the remote repository "origin"
# Using the HTTPS protocol
# The following Git command would be run:
# $ git push origin main

# if it looks good, run it for real ####
wflow_git_push()

# Results in Error Message:
# Error: Push failed for unknown reason.

# The error message from git2r::push() was:

# Error in 'git2r_push': too many redirects or authentication replays

# These sorts of errors are difficult to troubleshoot. You can search for similar errors on the git2r GitHub repository for
# advice on how to fix it.

# Alternatively, if you have Git installed on your machine, the easiest solution is to instead run `git push` in the
# terminal. This is equivalent to wflow_git_push(). Specifically, copy-paste the following in the terminal:

#  git push -u origin main

# ME: if it fails:
#-use Git CMD window
#-set prompt to project root directory using:
  #- 'D:'
  #- 'cd Dropbox\drizzolo_work\USFWS\drizzolo\Documents\projects\rtlo_acp_survey\workflowr_prj\rtlo_acp_survey\[folder you want to push]'
#-run: "git push -u origin"

# # NB if you push from the main directory (rtlo_acp_survey), then all files in sub-directories will be pushed
# (excluding those specified in the git ignore file, so be sure to add data files and source login files to git ignore)
#
# web URL: https://djrizz.github.io/rtlo_acp_survey/
