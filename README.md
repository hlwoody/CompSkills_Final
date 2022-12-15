# CompSkills_Final
Final project for Computational Skills in Biology, Fall 2022

The code included in this repository was written by Hannah Woody in December, 2022 and last updated 12.15.2022. 
Use of the "titanic" dataset that is a part of the R package, is neccessary for this code to function.

The purpose of the R script, "CompSkills_Final.R" is draw comparisons of survival rates between genders and classes of passengers on the Titanic. The first half of the script compares genders in each of the classes for percentage of survival, and outputs a stacked bar graph with % survival labeled. The second half of the script compares overall survival rates between men and women on the titanic, regardless of age or class, and produces a similar stacked bar graph. 

Build Status:
Currently the stacked bar graphs do not display full legends. 
On the first graph depicting survivorship between classes and genders, the alpha=0.4 bar in the back of plot is the total number of passengers that were present on the titanic prior to sinking, while the darker bar in the foreground of the plot displays the number of survivors from that catergory. Bars are colored based on gender of passengers ("fill=Sex") but additional labeling of survived vs. not survived has not been solved. 

Attempts to solve this issue are the following:
-Manually creating a legend that is not derived from data
-installing ggpatern package to give texture to survived vs not survived
-Filling the bars based on Survivorship status (ignores gender differences)
-Creating a vector of binary "Survived vs Not survived" and applying that to coloration of bars

The second graph that decipts overall survivorship between genders has a very similar issue, where the color of the bars is manually set, but does not display a legend.

Attemps to solve this issue are the following:
-Manually creating a lengend that is not dervived from data
-Creating binary vector to "fill" graph color based on survived, not survived. 

Possible Solutions: 

The titanic dataset already contains a Binary value for survived or not survived, which could be tied to sorted data as a way to fill bars. However, current sorting and filtering efforts do not easily combine this survived/not survived value.

