# Multiscale Combinatorial Grouping with Power Spectral Clustering

This repo consists of code to use MCG along with Power Spectral Clustering [article](https://hal.archives-ouvertes.fr/hal-01516649v2/document) instead of Normalized Cut. This was used to generate the Fig 7. in article "Power Spectral Clustering" [paper](https://hal.archives-ouvertes.fr/hal-01516649/document).

The original [MCG repo](https://github.com/jponttuset/mcg) was forked and changes were to the pre-trained version to adapt it to Power Spectral Clustering.

Steps
-----

1. Download the [BSDS500 Dataset](https://www2.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/resources.html) and save it to `./pre-trained/datasets/`
2. Run `./pre-trained/run_demo.m` to get a typical result and running times.
3. Results appear in `./pre-trained/demos/answer/`, and running times are printed on the MATLAB terminal.

In case answer on a manual image is required, change the file `./pre-trained/demos/demo_im2ucmV2.m` accordingly.

## Notes from original repository
MCG is the package code that implements the algorithms presented in:
 - Pont-Tuset J, Arbelaez P, Barron J, Marques F, Malik J,
 "Multiscale Combinatorial Grouping for Image Segmentation and Object Proposal Generation,"
 TPAMI 2016.

 - Arbelaez P, Pont-Tuset J, Barron J, Marques F, Malik J,
 "Multiscale Combinatorial Grouping,"
 CVPR 2014.

Please consider citing the papers if you use this code.

More info about MCG in the project page:
http://www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/mcg/

**CAUTION**

The **'full' package is not completely up to date**, use it only if you need to re-train the Pareto front or the ranking in MCG, then use 'pre-trained' to do the actual computations.

**'Full' and 'Pre-Trained' packages not compatible with Windows.**
