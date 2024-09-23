import pandas as pd
from metaflow import FlowSpec, step

class MultiCSVDataTransformationFlow(FlowSpec):

    @step
    def start(self):
        """
        Start step: Load data from multiple CSV files.
        """
        self.products = pd.read_csv('products.csv')
        self.sales = pd.read_csv('sales.csv')
        print("Products Data:")
        print(self.products)
        print("\nSales Data:")
        print(self.sales)
        self.next(self.merge_data)

    @step
    def merge_data(self):
        """
        Merge the products and sales data on product_id.
        """
        self.merged_data = pd.merge(self.sales, self.products, on='product_id')
        print("Merged Data:")
        print(self.merged_data)
        self.next(self.clean_data)

    @step
    def clean_data(self):
        """
        Clean the merged data by removing duplicates and NaN values.
        """
        self.cleaned_data = self.merged_data.drop_duplicates().dropna().reset_index(drop=True)
        print("Cleaned Data:")
        print(self.cleaned_data)
        self.next(self.feature_engineering)

    @step
    def feature_engineering(self):
        """
        Create new features based on the cleaned data.
        """
        self.cleaned_data['total_sales'] = self.cleaned_data['sale_amount']
        self.cleaned_data['sale_date'] = pd.to_datetime(self.cleaned_data['sale_date'])
        self.cleaned_data['year'] = self.cleaned_data['sale_date'].dt.year
        self.cleaned_data['month'] = self.cleaned_data['sale_date'].dt.month
        print("Features created:")
        print(self.cleaned_data)
        self.next(self.end)

    @step
    def end(self):
        """
        End step: Final output.
        """
        print("Data transformation flow completed.")
        print("Final transformed data:")
        print(self.cleaned_data)

if __name__ == "__main__":
    MultiCSVDataTransformationFlow()
