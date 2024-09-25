from metaflow import FlowSpec, step, current

class TaggingFlow(FlowSpec):

    @step
    def start(self):
        # Add a tag to the current run (flow run, not a specific step)
        current.run.add_tag('start_step_run')
        self.message = "This is a demo of tagging and metadata."
        print(self.message)
        self.next(self.process_data)

    @step
    def process_data(self):
        # Simulate some processing
        current.run.add_tag('processing_step_run')  # Add a tag to this run
        self.processed_data = self.message.upper()
        print(f"Processed Data: {self.processed_data}")
        self.next(self.end)

    @step
    def end(self):
        # Final step of the flow
        current.run.add_tag('end_step_run')
        print("Flow finished successfully!")

if __name__ == '__main__':
    TaggingFlow()
