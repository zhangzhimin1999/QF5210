install.packages("neuralnet")
library(neuralnet)
########################################################################

#   Parameters
window_size = 3 #use last three month data 
num_test = 1

########################################################################
data = matrix(0, nrow(case_data_sg1) - window_size, window_size +1 )
for (i in c(1:(nrow(case_data_sg1)-window_size))){
  # print(i)
  # print(AMZN[i:(i+window_size-1),"log_return"])
  data[i, 1:window_size] = case_data_sg1[i:(i+window_size-1)]
  data[i,window_size +1] =  case_data_sg1[i+window_size]
}
# Check the dimension of the data, break into training and testing
df = as.data.frame(data)
train = df[1:(nrow(df)-num_test),]
test = df[(nrow(df)-num_test+1):nrow(df),]
########################################################################
##################   Model
n = names(train) # return column names of dataframe
last = n[window_size+1]
f = as.formula(paste(paste(last,"~"), paste(n[!n %in% last],collapse="+"))) #specify the model input and output
actual_log_return = test[, window_size+1] # actual log return

#Model
########################################################################
## the below syntac means that three hidden layers with 20, 20, 10 nodes respectively, you could play with them
model = neuralnet(f, data=train, linear.output=T) 
# plot(model1)  #you could visualize the neural network generated
pred = compute(model, test[ ,c(1:(window_size))]) # prediction by model
pred_log_return = pred$net.result
mean(pred_log_return, actual_log_return)
