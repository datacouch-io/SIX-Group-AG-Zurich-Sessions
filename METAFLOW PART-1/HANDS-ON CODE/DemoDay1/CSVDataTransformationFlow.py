import pandas as pd
from metaflow import FlowSpec, step

class CSVDataTransformationFlow(FlowSpec):

    @step
    def start(self):
        """
        Start step: Load data from CSV.
        """
        self.raw_data = pd.read_csv('data.csv')
        print("Raw data:")
        print(self.raw_data)
        self.next(self.clean_data)

    @step
    def clean_data(self):
        """
        Clean the data by removing entries with NaN values.
        """
        self.cleaned_data = self.raw_data.dropna().reset_index(drop=True)
        print("Cleaned data:")
        print(self.cleaned_data)
        self.next(self.feature_engineering)

    @step
    def feature_engineering(self):
        """
        Create new features based on the cleaned data.
        """
        self.cleaned_data['double_value'] = self.cleaned_data['value'] * 2
        self.cleaned_data['is_even'] = self.cleaned_data['value'] % 2 == 0
        print("Features created:")
        print(self.cleaned_data)
        self.next(self.end)

    @step
    def end(self):
        """
        End step: Final output.
        """
        print("Data transformation flow completed.")
        print("Final features:")
        print(self.cleaned_data)

if __name__ == "__main__":
    CSVDataTransformationFlow()
