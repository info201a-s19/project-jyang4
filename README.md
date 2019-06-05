# Final Project

### Project Description

Our goal for the Yelp Data Project was to transform the 
[_Yelp_](https://www.yelp.com/dataset/challenge) data set and turn it into 
usable visuals for perspective business owners. Through our visualization, we
hope to provide prospective business owners with more insight on how they should
operate their business in terms of selecting a specific location or selecting a
price range that is competitive in the region. We provided several graphs to 
illustrate and answer our problem set. With Yelp and digital marketing becoming
_more and more important_, it can be important for new business owners to pay
attention to what data Yelp collects. We hope to provide a tool and resource
for these business owners to be more competitive. 

### Through our data report, we hope that the reader can:
- Learn about the *average price* range of restaurants
- Understand where the *highest rated* restaurants are in the region
- See the impact of *check-ins and reviews*

### The Data

Since the original Yelp Data Set consists of data in the continental 
United States, we felt that our report would be more beneficial if we partition
it to a specific city. We decided to use the _vibrant_ city of Las Vegas, NV, 
which is home to a number of top restaurants and business. We focused on data on
the cities of Las Vegas, North Las Vegas, and Henderson. 

### Tools that We Use

For this report, we utilized tools like "Dplyr", "Plotly", "GGPlot2",
and "Shiny". Dplyr was used primarily for data wrangling and sectioning off the
data to specific parts that we focused on. Plotly and GGPLot2 were used in 
creating interactive visualizations such as the map and the graphs. This tool
allowed us to transform the data that we wrangled with in Dplyr to a visual. 
Finally, we used the Shiny tool to create customized inputs, so that the visuals
were customized to the reader's needs. 

### Challenges

Some of the challenges we faced:
1. Using the data-set from Yelp that was originally a .json file
2. Seeing that the Las Vegas region had three different cities, so we had to
include all three cities when data wrangling
3. Having trouble decide what insights to get from such a large, broad data-set.
