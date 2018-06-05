## Luca - Feb.06, 2015 ##
# This script goes through sound files in a directory, 
# creates TextGrid files in the subdirectory "textgrid" (which must be already created), 
# calculates total duration of each sound file, 
# calculates the duration of the first X interval(s) [interval 1 = onset], 
# saves results to a *.csv file. 



form Get duration of segment(s) in files
	comment Directory of TextGrid files and Results 
	text textGrid_directory /Users/am2957/Desktop/Praat/
	sentence TextGrid_file_extension .TextGrid
	comment Name of the resulting file - the extension must be ".csv":
	sentence resultfile_name Output2.csv

endform

#Makes excel doc have same name as what was inputted earlier
resultfile$ = "'textGrid_directory$''resultfile_name$'"

# see if output file exists already
if fileReadable (resultfile$)
	pause The result file 'resultfile$' already exists! Do you want to overwrite it?
	filedelete 'resultfile$'
endif

# listing of all the sound files in directory

Create Strings as file list... list 'textGrid_directory$'*'TextGrid_file_extension$'
numberOfFiles = Get number of strings
pause 'numberOfFiles' files identified. Continue?  

#creates header in excel document
titleline$ = "Filename,interval_no,interval_label,interval_duration,total_duration'newline$'"
fileappend "'resultfile$'" 'titleline$'

# loop through all files. 
for ifile to numberOfFiles

    filename$ = Get string... ifile
	Read from file... 'textGrid_directory$''filename$'

    # check the number of intervals in the tier:
    numberOfIntervals = Get number of intervals: 1

    # loop through all the intervals. 
    # everything between "for" and "endfor" will be calculated for each interval
     
         for interval from 1 to numberOfIntervals
              label$ = Get label of interval: 1, interval
              start = Get start point: 1, interval
              end = Get end point: 1, interval
              duration = end - start
              # save the results
              resultline$ = "'filename$','label$','start:4','end:4','duration:4''newline$'"
				fileappend "'resultfile$'" 'resultline$'
         endfor
    Remove
      select Strings list

endfor

