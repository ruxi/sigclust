library(sigclust)
print(sprintf("First the data in data2.tsv"))
print(sprintf("Please wait..."))

#set 1 for Soft thresholding, 2 for no dimensionality reduction,  3 for hard thresholding
version <- 1
scale <- TRUE

data_2 = read.table("enwiki_data/data2.tsv", stringsAsFactors = FALSE)
features_2 = data_2[2:(ncol(data_2)-1)]
features_2[features_2 == "True"] <- 1
features_2[features_2 == "False"] <- 0

data_mat = data.matrix(features_2)

if (scale) {data_mat = scale(data_mat)}
   
sig_obj = sigclust(data_mat, nsim = 100, icovest = version)
sims = sig_obj@simcindex
mean = mean(sims)
sd = sd(sims)

print(sprintf("pval :  %f", sig_obj@pval))
print(sprintf("cluster index for input data:  %f", sig_obj@xcindex))
print(sprintf("The simulated cluster indices had a mean of %f and a standard deviation of %f.", mean, sd))


##Run sigclust on random data of same dim.
print(sprintf("Now for a matrix of the same dimensions with rnorm entries"))
print(sprintf("Please wait..."))
nrow = dim(data_mat)[1]
ncol = dim(data_mat)[2]
tot_vals = length(data_mat)

rand_mat_0 = matrix(rnorm(tot_vals, mean = 0, sd = 1), nrow = nrow, ncol=ncol)

sig_obj_0 = sigclust(rand_mat_0, nsim = 100, icovest = version)
sims0 = sig_obj_0@simcindex
mean0 = mean(sims0)
sd0 = sd(sims0)

print(sprintf("pval: %f", sig_obj_0@pval))
print(sprintf("cluster index of input:  %f", sig_obj_0@xcindex))
print(sprintf("The simulated cluster indices had a mean of %f and a standard deviation of %f.", mean0, sd0))


## Two halves from their own normal

print(sprintf("Letting half of input data be from N(0,1) and hald be from N(.5, 1)"))
print(sprintf("Please wait..."))

ncol_1_1 = floor(ncol / 2)
ncol_1_2 = ncol - ncol_1_1

rand_mat_1_1 = matrix(rnorm(nrow*ncol_1_1, mean = 0, sd = 1), nrow = nrow, ncol = ncol_1_1)

rand_mat_1_2 = matrix(rnorm(nrow*ncol_1_2, mean = .5, sd = 1), nrow = nrow, ncol = ncol_1_2)

rand_mat_1 = rbind(rand_mat_1_1, rand_mat_1_2)

sig_obj_1 = sigclust(rand_mat_1, nsim= 100, icovest = version)
sims1 = sig_obj_1@simcindex
mean1 = mean(sims1)
sd1 = sd(sims1)


print(sprintf("p-value:  %f", sig_obj_1@pval))
print(sprintf("cluster index of input:  %f", sig_obj_1@xcindex))
print(sprintf("The simulated cluster indices had a mean of %f and a standard deviation of %f.", mean1, sd1))
