#install.packages("caret")
#install.packages("factoextra")
bank.full <- read.csv("~/Cummins/Third Year/Sem5/Labs/Stats Lab/bank/bank-full.csv", sep=";")

#Data pre-processing

#Analysing the dataset
#there are no missing values in the dataset - which(is.nan(bank.full$age))

#converting categorical data to numeric data using one-hot encoding 
#one-hot encoding
library(caret)
dmy <- dummyVars(" ~ .", data = bank.full)
bank.full <- data.frame(predict(dmy, newdata = bank.full))
#dropping unneccessary columns 
drops <- c("y.no","default.no","contact.unknown","housing.no","loan.no")
bank.full = bank.full[ , !(names(bank.full) %in% drops)]

#checking correlation of variables with y.yes
cormatrix = cor(bank.full) #default pearson
corr = as.matrix(cormatrix[1:47,48]) #to view correlation with y.yes
png(file = "correlation_with_y.png")
barplot(as.vector(corr),names.arg=rownames(corr)[1:47] ,xlab="Features",ylab="Correlation with y.yes",col="blue", main="Chart showing Correlation",border="red")
dev.off()
#dropping unnecessary columns 
bank.full$job.self.employed <- NULL
bank.full$job.unknown <- NULL
bank.full$job.technician <- NULL
bank.full$job.admin <- NULL

#normalize data - we don't need to normalize the outcome feature, ie, last feature
scaled.bank.full <- scale(bank.full[,1:44])
scaled.bank.full = data.frame(as.data.frame(scaled.bank.full))
# check that we get mean of 0 and sd of 1
colMeans(scaled.bank.full)  # faster version of apply(scaled.dat, 2, mean)
apply(scaled.bank.full, 2, sd)

#split into training and test data 
train.nrows = floor(nrow(scaled.bank.full)*.7)
train = data.frame(scaled.bank.full[1:train.nrows,], y.yes = bank.full$y.yes[1:train.nrows])
test = data.frame(scaled.bank.full[train.nrows+1:nrow(bank.full), ])
test = test[complete.cases(test), ]
#test = data.frame(test, y.yes = bank.full$y.yes[1+train.nrows:(nrow(bank.full)-1)])

#logistic regression without dimensionality reduction 
formula = y.yes ~ .
bank.result.nopca = glm(formula, data = train, family = gaussian)
summary(bank.result.nopca)
pred <- predict(bank.result.nopca, newdata = test, type = "response")
#Warning message:
#In predict.lm(object, newdata, se.fit, scale = 1, type = if (type==:prediction from a rank-deficient fit may be misleading
#using too many predictors in the formula of glm for the data you gave.

#principal component analysis 
library(factoextra)
res.pca = prcomp(train[,1:44])

#Visualize eigenvalues (scree plot). Show the percentage of variances explained by each principal component.
png(file = "Scree_plot_principle_components.png")
fviz_eig(res.pca)
dev.off()

#Graph of variables. Positive correlated variables point to the same side of the plot. Negative correlated variables point to opposite sides of the graph.
png(file = "correlation_of_variables.png")
fviz_pca_var(res.pca,
             col.var = "contrib", # Color by contributions to the PC
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE     # Avoid text overlapping
)
dev.off()

#add a training set with principal components
train.data = data.frame(res.pca$x[,1:10], y.yes = train$y.yes)
#transform test into PCA
test.data <- as.data.frame(predict(res.pca, newdata = test))[,1:10]

#make prediction on test data
bank.result.pca = glm(y.yes~., data = train.data, family = gaussian)
summary(bank.result.pca)
pred <- predict(bank.result.pca, newdata = test.data, type = "response")
pred = ifelse(pred > 0.5, 1, 0)
score = mean(pred == bank.full$y.yes[1+train.nrows:(nrow(bank.full)-1)])

#classification score 
cat("Score: ",score*100) #74.5724

