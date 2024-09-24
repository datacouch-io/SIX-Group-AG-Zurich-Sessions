import os
from metaflow import Flow
import subprocess


def test_flow():
    # Command to run the flow
    cmd = ['python', 'complex_flow.py', 'run', '--run-id-file', 'test_id']
    subprocess.check_call(cmd)

    # Read the run ID from the file
    with open('test_id') as f:
        run_id = f.read().strip()  # Use .strip() to remove any extra whitespace

    # Load the flow run and check the outputs
    run = Flow('ComplexFlow')[run_id]

    # Assertions to validate the outputs
    assert run.data.numbers == [1, 2, 3, 4, 5]
    assert run.data.squared_numbers == [1, 4, 9, 16, 25]
    assert run.data.total_sum == 55
    assert run.data.max_value == 25
