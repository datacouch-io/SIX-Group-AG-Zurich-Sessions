from metaflow import FlowSpec, step

class UnderstandingFlow(FlowSpec):

    @step
    def start(self):
        """
        Step 1: Start of the flow.
        This is the entry point of the flow where we initialize variables.
        """
        self.data = 10  # Initialize some data
        print(f"Starting flow with initial data: {self.data}")
        self.next(self.process_data)  # Transition to the next step

    @step
    def process_data(self):
        """
        Step 2: Processing the data.
        This step represents a task where we manipulate the data.
        """
        print(f"Processing data: {self.data}")
        self.processed_data = self.data * 2  # Example processing (doubling the data)
        print(f"Processed data: {self.processed_data}")
        self.next(self.end)  # Transition to the final step

    @step
    def end(self):
        """
        Step 3: End of the flow.
        This step concludes the flow and outputs the final results.
        """
        print("Flow completed.")
        print(f"Final processed data: {self.processed_data}")

if __name__ == '__main__':
    UnderstandingFlow()
