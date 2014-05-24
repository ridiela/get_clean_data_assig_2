Simple Guide For The Project
===================================================================

**This is a brief summary of whats and whys,
split in five steps.**

(NULL) Step: Getting Data
-------------------------

I suppose that the relevant data is already downloaded and uncompressed

1st Step: Introducing data in R and first formatting
----------------------------------------------------

* Read all the files into R as dataframes 
* For ease of reading, use presentaed names as labels for the features' columns
* For ease of reading, use "labels" as the column name for the activities
* For ease of reading, use "subjects" as the column name for the subjects
* cBind (append) dataframes of the same sets (train and test) together
* Finally, merge the resultat dataframes based on common column names

2nd Step: Subset mean and stantard_deviation features from dataframe
--------------------------------------------------------------------

* Get column names for all the features
* Extract into a new dataframe only those that contain "mean" or "std", 
	in a case sentitive way, as shown in the readme of the original dataset.
* ReAdd to the new dataset the columns corresponding to activities and subjects 

3rd Step: Rename activities in a descriptive way
------------------------------------------------

* Get a new auxiliary dataframe into R pairing activity number with activity name
* Merge thes new dataset with the last one based on those factors
* Drop unnecesary columns


4th Step: Rename fetures in a descriptive way
---------------------------------------------

* Make column names more descriptive, changeing what it is deemed as convenient

5th Step: Creates new, tidy data set with the average of each variable for each activity and each subject
---------------------------------------------------------------------------------------------------------

* Make use of function "aggregate" to group data as reqwuested while calculating the means
* Write new dataset into a csv file

