## Luca Campanelli & Alekya Menta ##
## June 5, 2018 ##
# This script goes through TextGrid files in the specified directory, 
# creates TextGrid files in the subdirectory "textgrid" (which must be already created), 
# calculates total duration of each sound file, 
# calculates the duration of the first X interval(s) [interval 1 = onset], 
# saves results to a *.csv file. 


# input window
form Get TextGrid info
     comment DIRECTORY OF TextGrid FILES AND RESULTS
     comment Address must end with slash (Linux and Mac) or backslash (PC)
     text textGrid_directory /Users/name/myproject/
     sentence TextGrid_file_extension .TextGrid
     comment Name of the results file (it will be a csv file):
     sentence results_file_name output1.csv
endform

# define results file name and directory
resultfile$ = "'textGrid_directory$''results_file_name$'"

# see if output file exists already
if fileReadable (resultfile$)
    pause The result file 'resultfile$' already exists! Do you want to overwrite it?
    filedelete 'resultfile$'
endif

# make a list of TextGrid files
Create Strings as file list... list 'textGrid_directory$'*'TextGrid_file_extension$'
numberOfFiles = Get number of strings
pause 'numberOfFiles' files identified. Continue?  

#creates header in results document
titleline$ = "file,int_no,int_label,int_start,int_end,int_dur'newline$'"
fileappend "'resultfile$'" 'titleline$'

# loop through all files
for ifile to numberOfFiles

     filename$ = Get string... ifile
     Read from file... 'textGrid_directory$''filename$'

     # check the number of intervals in the tier:
     numberOfIntervals = Get number of intervals: 1

     # loop through all the intervals. 
     # everything between "for" and "endfor" will be calculated for each interval     
     for interval from 1 to numberOfIntervals
          int_no = interval
          label$ = Get label of interval: 1, interval
          start = Get start point: 1, interval
          start = start * 1000
          end = Get end point: 1, interval
          end = end * 1000
          duration = end - start
          # save the results
          resultline$ = "'filename$','int_no','label$','start:0','end:0','duration:0''newline$'"
          fileappend "'resultfile$'" 'resultline$'
     endfor

     Remove
     select Strings list
endfor

