clear;clc;close all
clear global
clear classes
dbstop if error

interspace = [0 0; 1 1; 0 0; 0 0];

Foot_index = minFootInterSpace(interspace, 2)