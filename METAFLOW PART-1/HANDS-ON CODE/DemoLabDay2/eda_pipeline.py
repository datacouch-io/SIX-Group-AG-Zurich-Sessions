import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from metaflow import FlowSpec, step, current


class EDAPipelineFlow(FlowSpec):

    @step
    def start(self):
        """
        Step 1: Load the dataset from a CSV file.
        Ensure the CSV file is available in the working directory.
        """
        print("Loading the Iris dataset from CSV...")
        self.data = pd.read_csv('iris.csv', header=None,
                                names=['sepal_length', 'sepal_width',
                                       'petal_length', 'petal_width', 'species'])
        print(f"Dataset loaded with shape: {self.data.shape}")
        self.next(self.data_summary)

    @step
    def data_summary(self):
        """
        Step 2: Perform basic data profiling (summary statistics).
        """
        print("Generating summary statistics...")
        self.summary = self.data.describe()
        self.missing_values = self.data.isnull().sum()

        print("Summary statistics:\n", self.summary)
        print("Missing values:\n", self.missing_values)
        self.next(self.visualize_data)

    @step
    def visualize_data(self):
        """
        Step 3: Visualize the data with histograms and pair plots.
        - Histogram for each numeric column.
        - Pairplot to visualize relationships between features.
        """
        print("Generating data visualizations...")

        # Histogram for each numeric column
        for column in self.data.select_dtypes(include=['float64', 'int64']).columns:
            plt.figure(figsize=(8, 6))
            sns.histplot(self.data[column], kde=True, color='skyblue')
            plt.title(f'Histogram of {column}')
            plt.xlabel(column)
            plt.ylabel('Frequency')
            hist_filename = f'{current.flow_name}_{current.run_id}_{column}_histogram.png'
            plt.savefig(hist_filename)
            plt.close()  # Close the figure to free memory
            print(f"Saved histogram: {hist_filename}")

        # Pairplot to visualize feature relationships
        pairplot_filename = f'{current.flow_name}_{current.run_id}_pairplot.png'
        sns.pairplot(self.data, hue='species')
        plt.savefig(pairplot_filename)
        plt.close()  # Close the figure to free memory
        print(f"Saved pair plot: {pairplot_filename}")

        self.next(self.end)

    @step
    def end(self):
        """
        Step 4: End the flow.
        """
        print("EDA flow finished successfully!")
        print(f"Summary Statistics:\n{self.summary}")
        print(f"Missing Values:\n{self.missing_values}")


if __name__ == '__main__':
    EDAPipelineFlow()
