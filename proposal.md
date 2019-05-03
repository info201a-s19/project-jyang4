# Info 201 Project Proposal

# Domain of Interest

### Why are you interested in this field/domain?
Yelp is an interesting product to take a deeper dive into because of its impact on businesses. Many users use Yelp to gain a first impression on businesses, and use it as a platform to write reviews for other Yelp users to see. Boasting over 178 million unique users, Yelp has significant impact on the success of business. As regular users who use Yelp, we are interested in how consumers rate business and how businesses use the crowd-sourced review to impact business decision. We wanted to take a look at the data to see what correlation and insights we can obtain from looking at Yelp Data.

### What other examples of data driven project have you found   related to this domain (share at least 3)?
- [Boston Consulting Group](https://blog.yelp.com/wp-content/uploads/2013/03/boston-consulting-group-study.pdf): Boston Consulting Group took a look at 4800 businesses to see the economic impact if any of having a yelp account vs not having a Yelp account. They found that having a Yelp account correlated with an $8,000 increase in annual revenue.
- [Yelp Explorers Data Analysis](https://bcourses.berkeley.edu/files/65096751/download?download_frd=1): A group from UC Berkeley wanted to see if you could predict the Yelp rating of a business by looking at keywords. They averaged an 80% accuracy based off three different tests.
- [Insight Data Science](https://towardsdatascience.com/using-yelp-data-to-predict-restaurant-closure-8aafa4f72ad6): The project involved trying to predict if a restaurant will close based off of Yelp reviews and star rating. They found that review were a good predictor and star rating was not.

### What data-driven questions do you hope to answer about this domain (share at least 3)?
- In each state, what is the most popular type of restaurant?
  - This can be answered by using the tags associated with each business, and using its location to determine the state.
- What is the average rating for each price bracket?
  - There is a price range for each business so we can group all the price range for businesses and find the average rating among each price range.
- What is the price bracket for each business tag type?
  - There can be up to three tags for each business, so for consistency only the first tag will be used when analyzing the price bracket, which is given by Yelp, for each tag type.
- Is there a trend between price range and average food rating?
  - The average food rating can be grouped by each increment of half star, and the average price range for each star rating.

# Finding Data
### Where did you download the data (e.g., a web URL)?
Web URL: https://www.yelp.com/dataset/challenge

### How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?
- The data was collected directly from Yelp. Yelp is a crowd-sourced platform who collects data from users. Users of the Yelp service will leave information such as reviews, photos, rating, and tips about the service. Yelp aggregates the data to deliver insights for their users. The data presents us data about the reviews and photos that consumers leave for company. In addition, the data also lets us additional information about each business such as address, category, and price range.

### How many observations (rows) are in your data?
### How many features (columns) are in the data?
### What questions (from above) can be answered using the data in this dataset?
