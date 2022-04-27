# understanding how to build contrasts in SPM

K. Garner, 2022

This code goes through how to build contrasts for a general linear model, with a focus on application in [SPM](https://www.fil.ion.ucl.ac.uk/spm/software/spm12/). 

I largely go through section 5 of Henson & Penny (2005) ANOVAs and SPM
https://www.fil.ion.ucl.ac.uk/~wpenny/publications/rik_anova.pdf as well as adapting
code from the spm_make_contrasts.m function from spm12 (Penny, W. 2005-2012,
% Wellcome Trust Centre for Neuroimaging).

Following the operations and the resulting contrast vectors should give you a feel for how to construct your own contrasts for your M-way ANOVA.

Any questions, then submit an issue on this repo :)

