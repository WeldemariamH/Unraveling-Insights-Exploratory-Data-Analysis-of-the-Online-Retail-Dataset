
         ###### an Explanatory data analytics UK-based and registered non-store online retail######
             #####    01/12/2010 and 09/12/2011   ######




install.packages("readxl")
library(readxl)


         ##### Data Exploration,cleaning and preprocessing######

data=read_excel('D:/Data Analytics project/Explanatory data analytics on online retail sales using R and Powerbi/Online Retail.xlsx')
data
structure(data)                     # to check the data structure

colnames(data)                      # to check the columns name 
head(data,10)                       # to check on the content of the first 10 raws as a sample
tail(data,10)                       # to check the last raws
typeof(data)                        #to check the data type
typeof(data$CustomerID)

is.na(data)                         # to check if there is any missing values

data<-data[data$UnitPrice > 0, ]    # removing raws with zero and negative price values
structure(data)

boxplot(data$UnitPrice)
outliers<-boxplot(data$UnitPrice)   #to see the outliers


            #####  Descriptive Analysis  #####
   ### statistical analytics for the column unit price to see the total sales,the maximum and minimum sold price and the average of the column

mean(data$UnitPrice)
median(data$UnitPrice)
max(data$UnitPrice)
min(data$UnitPrice)
sum(data$UnitPrice)


sum(data$Quantity)                #for the quantity column just to see the total number of sold items in the time period


total_returned<-sum(grepl('C',data$InvoiceNo))       #to see the total returned orders using the 'C' string in the Invoice number
total_returned

######Feature engineering to create new columns########

data$total_sales_per_transaction<-data$Quantity*data$UnitPrice  # creating a new column for total sales per transaction
install.packages("lubridate")
library(lubridate)

## the below lines are creating different columns of the time of purchase
data$InvoiceDate <- ymd_hms(data$InvoiceDate)        #converting the column to a POSIXct object(class that represents date and time values)
data$Date <- format(data$InvoiceDate, "%d")
data$Month <- month(data$InvoiceDate)
data$Year <- year(data$InvoiceDate)
data$Hour <- hour(data$InvoiceDate)
data$Minute <- minute(data$InvoiceDate)
data$DayOfWeek <- format(data$InvoiceDate, "%A")      #creating a column with the name of the day of purchase 

#### to export my file as an excel file

install.packages('writexl')
library(writexl)
write_xlsx(data,'D:/Data Analytics project/Explanatory data analytics on online retail sales using R and Powerbi/cleaned and process.xlsx')
