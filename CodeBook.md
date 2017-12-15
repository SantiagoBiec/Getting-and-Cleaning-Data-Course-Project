# CodeBook

## Overview
30 volunteers performed 6 different activities while wearing a smartphone.
Some variables were tracked through the smartphone and pre-treated to create some predictive features.
The obtained dataset has been randomly partitioned into two sets, training and set.

### The dataset includes the following files:



* 'features_info.txt': Shows information about the variables used on the feature vector.

* 'features.txt': List of all features.

* 'activity_labels.txt': Links the class labels with their activity name.

* 'train/X_train.txt': Training set.

* 'train/y_train.txt': Training labels.

* 'test/X_test.txt': Test set.

* 'test/y_test.txt': Test labels.

## Code

In the `run_analysis.R` code there are not auxiliary functions.
But it is possible disntinguish several steps.

1. There is a loop in which I go thorugh the `y_xxxx.txt` and `subject_xxxx.txt` for the train and test datasets.
Inside of it there is an extra loop to go along all the .txt's included inside of the `Inertial Signals`folder. In it I get the mean and standard deviation of all the variables contained.

1. I merged the dataset for the train and tests datasets.
1. It is revalued the variable of the activity, in order to be readbable. In the original dataset it is coded numerically and can not be interpreted withouth checking the `activity_labels.txt`
1. The dataset is reshaped to compute what is the mean of each feature, per subject and activity.
1. The reshaped dataset is written in a .txt named  `Assignment4.txt' 
