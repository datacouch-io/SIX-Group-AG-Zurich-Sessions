from metaflow import FlowSpec, step, batch
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error


class HousePricePredictionPipeline(FlowSpec):

    @step
    def start(self):
        """Load the dataset."""
        print("Loading house prices dataset...")
        self.data = pd.read_csv('house_prices.csv')
        print(f"Dataset loaded with {len(self.data)} records.")
        self.next(self.feature_engineering)

    @step
    def feature_engineering(self):
        """Perform feature engineering."""
        print("Performing feature engineering...")
        self.features = self.data[['area', 'beds', 'baths']]
        self.labels = self.data['price']

        # Split the data into training and test sets
        self.X_train, self.X_test, self.y_train, self.y_test = train_test_split(
            self.features, self.labels, test_size=0.2, random_state=42
        )
        print("Feature engineering completed.")
        self.next(self.train_model)


    @step
    def train_model(self):
        """Train the regression model."""
        print("Training the model...")
        self.model = LinearRegression()
        self.model.fit(self.X_train, self.y_train)
        print("Model training completed.")
        self.next(self.evaluate_model)

    @step
    def evaluate_model(self):
        """Evaluate the model performance."""
        print("Evaluating model performance...")
        predictions = self.model.predict(self.X_test)
        mse = mean_squared_error(self.y_test, predictions)
        print(f"Mean Squared Error: {mse}")
        self.next(self.end)

    @step
    def end(self):
        """End of the pipeline."""
        print("House price prediction pipeline completed.")


if __name__ == '__main__':
    HousePricePredictionPipeline()
