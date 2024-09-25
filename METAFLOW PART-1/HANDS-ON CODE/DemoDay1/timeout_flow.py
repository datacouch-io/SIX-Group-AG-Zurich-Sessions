from metaflow import FlowSpec, step, timeout

class TimeoutFlow(FlowSpec):

    @step
    def start(self):
        print("Starting TimeoutFlow")
        self.next(self.long_step)

    @timeout(seconds=15)  # Step must complete within 5 seconds
    @step
    def long_step(self):
        import time
        print("Simulating a long-running step...")
        time.sleep(10)  # Sleep for 10 seconds, which will trigger the timeout
        self.next(self.end)

    @step
    def end(self):
        print("TimeoutFlow completed")

if __name__ == "__main__":
    TimeoutFlow()
