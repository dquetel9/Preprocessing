# Preprocessing
This will be the destination for all optimized preprocessing code.  This includes functions that load data into matlab after recordings,
and keeping track of animal/ session metadata. 

# Dependencies/ notes
1. Keep recording data in the specific order of animal folder (written as m17, m18, m19 etc) with recording session folders/ experiments    within each animal folder
Ex:  D:\Data\m17\m17_190503_122105

2. All code should be made to be buzcode compatible.  
buzcode github link (https://github.com/buzsakilab/buzcode/tree/0312cfdf7f29528e75e03dd6d547b1313702e6a6)

3. We use the intan recording system for all of our recording and it creates a session folder for each recording with all of the necessary files inside. 

4. Auxilary programs that will be needed are Neuroscope, NDManager, and Klusters 
link to those downloades (http://neurosuite.sourceforge.net/)

This README aims to explain those contents and how to get them into a working format for data analysis.


# Recording files made by intan
1. amplifier.dat
2. analogin.dat
3. auxilary.dat
4. digitalin.dat
5. supply.dat
6. time.dat
7. info.rhd
8. amplifier.xml (this should be made ahead of time by you so that you can watch the recording live)

Neuroscope is the program used to view the .dat files.  Once you open a .dat file in Neuroscope it will make a new .nrs and .xml of the .dat file name. NOTE: Neuroscope won't open the .dat files if the existing .xml file doesn't match the .nrs file

NDManager is the program used to view and edit the .xml files 

# Functions used in preprocessing 
   - Some more information on each of these functions can be found in their help sections but ultimately the best way to learn what they have in them is to use them
1. bz_RunAnimalMetadata.m
    - This function creates a text file containing all of the metadata for the individual animal. This includes date of birth, surgery     data, some recording info, animal strain, etc.
2. bz_RunSessionMetadata.m
    - This function creates a text tile containing all of the metadata for the recording session.  This includes lecording locations,   probe type, probe angles, type of recording (optogenetic, intracellular), etc.
3. bz_getSessionInfo
    - This function creates a sessionInfo.mat file that has many fields corresponding to the recording/ probe specifications.
4. bz_LFPfromDat
    - This function loads the .dat file into a .lfp file (can be used for all .dat files, but we normally use it for the amplifier).
5. bz_GetLFP
    - This function loads the .lfp file into your workspace for use and manipulation with other functions (int16).
6. bz_GetSTIM
    - This function loads the .lfp file into your workspace for use and manipulation with other functions (uint16).
7. bz_isLFP
    - This function checks that the lfp variable in your workspace is of the correct structure and has the necessary components
8. Preprocessing_info.m
    - This file has some more information on the functions and how to use them as well as some fixes for problems that you may run into
