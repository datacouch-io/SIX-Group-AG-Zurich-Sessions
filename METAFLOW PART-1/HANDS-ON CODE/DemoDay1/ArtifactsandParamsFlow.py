from metaflow import FlowSpec, step, Parameter

class MyParameterFlow(FlowSpec):
    input_text= Parameter("input_text",default="Hello Metaflow ",help="Input Text for the flow")
    multiplier = Parameter("multiplier", default=2, type=int, help="multiplier for processing the input")

    @step
    def start(self):
        print(f"Input Text: {self.input_text}")
        print(f"Multiplier: {self.multiplier}")
        self.next(self.handle_artifacts)

    @step
    def handle_artifacts(self):
        self.processed_text = self.input_text*self.multiplier
        print(f"Processed text : {self.processed_text}")
        self.next(self.display_results)

    @step
    def display_results(self):
        print(f"Final Processed Text : {self.processed_text}")
        self.next(self.end)

    @step
    def end(self):
        print("End Step Completed")

if __name__ == '__main__':
    MyParameterFlow()
