import matplotlib.pyplot as plt
import numpy as np
from metaflow import FlowSpec, step, current

class DataPipelineFlow(FlowSpec):

    @step
    def start(self):
        """
        Step 1: Simulate Data Generation.
        We simulate some random data for demonstration purposes.
        """
        print("Generating random data...")
        np.random.seed(42)
        self.data = np.random.normal(0, 1, 1000)  # 1000 random data points
        print(f"Data generated: {self.data[:5]}...")  # Print first 5 data points
        self.next(self.process_data)

    @step
    def process_data(self):
        """
        Step 2: Process the data.
        For this example, let's calculate the histogram of the data.
        """
        print("Processing data (creating histogram)...")
        self.hist, self.bin_edges = np.histogram(self.data, bins=30)
        print(f"Histogram calculated: {self.hist[:5]}...")  # Print first 5 histogram bins
        self.next(self.generate_chart)

    @step
    def generate_chart(self):
        """
        Step 3: Generate a chart using Matplotlib.
        We will create a histogram and save it as an image.
        """
        print("Generating chart...")

        # Plot the histogram
        plt.figure(figsize=(8, 6))
        plt.hist(self.data, bins=30, color='skyblue', edgecolor='black')
        plt.title('Histogram of Generated Data')
        plt.xlabel('Data Values')
        plt.ylabel('Frequency')

        # Save the chart as a PNG image
        chart_filename = f'{current.flow_name}_{current.run_id}_histogram.png'
        plt.savefig(chart_filename)
        print(f"Chart saved as {chart_filename}")

        self.next(self.end)

    @step
    def end(self):
        """
        Final step: Notify that the flow has completed.
        """
        print("Flow finished successfully!")

if __name__ == '__main__':
    DataPipelineFlow()
