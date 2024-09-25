from metaflow import FlowSpec, step, catch

class CatchFlow(FlowSpec):

    @step
    def start(self):
        print("Starting CatchFlow")
        self.next(self.process)

    @catch(var='error_info')  # Capture errors in this step
    @step
    def process(self):
        print("Processing...")
        raise ValueError("Simulated error in process step")
        self.next(self.end)

    @step
    def end(self):
        if hasattr(self, 'error_info'):
            print(f"Error caught: {self.error_info}")
        else:
            print("CatchFlow completed successfully")

        print("End step completed successfully")

if __name__ == "__main__":
    CatchFlow()
