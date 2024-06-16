# Exam 1: Analysis

# Add your solutions to the spaces provided and save as a .R file according
# to the instructions on Canvas. Do not include any output from your code
# in your submission. I can run your R code to generate the output if needed. 
# For questions requiring written answers, write your answers using comments 
# as shown here. 

######################################################################
# You've been tasked with promoting Illinois State to prospective 
# students, so to devise your marketing strategy, you want to better 
# understand how ISU compares to its competitors: other four-year, 
# public universities in Illinois. 
# 
# Data has been downloaded from the US Department of Education College
# Scorecard at https://collegescorecard.ed.gov/data/ and filtered to 
# four-year, Illinois public universities for you. In addition, the 
# initial file from the US Dept of Education had 3,214 columns,
# but it's been limited to just 44 columns for this analysis.
#
# There is a data dictionary to describe each of the columns in detail
# provided by the US Dept of Education and included on Canvas. 
######################################################################

######################################################################
# Task 1 (3 points)
# Read the 'il-fouryear-public-schools.csv' into R as a data frame 
# called il_schools. Make sure the file is in your working directory. 
# Do not include any calls to setwd() in your script when submitting.
######################################################################

il_schools = read.csv("il-fouryear-public-schools.csv")

######################################################################
# Task 2 (6 points)
# Write at least THREE R commands to explore the il_schools data. For 
# example, you might look at how many schools are included. You might
# check for missing values. (These are just examples. Write commands 
# to show what YOU want to know about the data frame before continuing 
# your analysis.)
######################################################################

str(il_schools$INSTNM, il_schools$CITY)
summary(il_schools)
unique(il_schools$INSTNM)
mean(il_schools$GRAD_DEBT_MDN)

######################################################################
# Task 3
# Part 1 (6 points)
# Using at least TWO of the numeric columns in the il_schools data,
# define a metric that will help prospective students decide whether 
# ISU is an attractive school. You will need to reference the data
# dictionary (download from Canvas) to know what each of the columns 
# mean. VARIABLE NAME in the Excel file will align with the column name
# in the data frame.
#
# One example: You might define a "debt ratio" that compares median debt 
# after graduation to cost of attendance.
# 
# You are welcome to use this example, but more credit will be 
# given to those who define their own metric. See the assignment on
# Canvas for more detail on grading criteria for this question.
#
# In a sentence or two, describe your metric and what it is intended 
# to measure. Your description should be clear and concise. 
######################################################################

# I choose to use a Cost to Earnings Ratio that compares the Average cost to attend
# to the Median Earnings after 4 years of completing study. This is an ROI type metric
# allowing us to compare outcomes across Institutions after graduation.

######################################################################
# Task 3 
# Part 2 (6 points)
# Add your metric as a new column to the il_schools data frame. Give 
# the column a name that reflects your metric. 
######################################################################

il_schools$COSTEARNRATIO = il_schools$COSTT4_A / il_schools$MD_EARN_WNE_4YR

######################################################################
# Task 4 (6 points)
# Add a column to the il_schools data frame called isu_indicator that is 
# 'ISU' for rows where INSTNM is 'Illinois State University', and
# 'Other Universities' otherwise.   
######################################################################

il_schools$isu_indicator = ifelse(il_schools$INSTNM == 'Illinois State University', 'ISU', 'Other Universities')
  
######################################################################
# Task 5 (6 points)
# Calculate the average of your metric defined in task 3 for ISU vs. 
# Other Universities.
######################################################################

isu_mean = mean(il_schools[il_schools$isu_indicator == 'ISU', ]$COSTEARNRATIO)
others_mean = mean(il_schools[il_schools$isu_indicator == 'Other Universities', ]$COSTEARNRATIO)


######################################################################
# Task 6 (6 points)
# Using il_schools, build a plot of your choice to compare your metric 
# across all schools (INSTNM) in the data set. Make sure your plot is 
# colored/filled by the isu_indicator column to make it easy to see 
# how ISU compares.
#
# Give your plot titles and axis names to make it look professional.
# Include the code here that builds your plot. Don't forget to load
# the ggplot2 library. 
######################################################################


library(ggplot2)

ggplot(il_schools) +
 aes(x = INSTNM, y = COSTEARNRATIO, fill = isu_indicator) +
 geom_col() +
 scale_fill_hue(direction = 1) +
 labs(x = "Institution Name", y = "Cost to Earnings Ratio", title = "Return on Investment by Institution", 
 fill = "Institution Indicator") +
 coord_flip() +
 theme_minimal()


######################################################################
# Task 7 (6 points)
# Using your results from the last two tasks, would your metric 
# be a good metric to use for attracting students to ISU? Include at 
# least 2 sentences to explain why or why not. 
######################################################################

# It would not be a good metric because Cost to Earning ratios for other institutions
# are on average lower than that of ISU, indicating that after completing their studies 
# Students in other institutions earn more for every Dollar spent getting their education.
# For ISU students earn about $1,68 for every $1 spent in ISU.
