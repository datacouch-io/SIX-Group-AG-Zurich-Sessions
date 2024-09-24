import os
from metaflow import Flow
import subprocess
import pytest


def run_flow():
    # Command to run the flow
    cmd = ['python', 'complex_flow_env.py', 'run', '--run-id-file', 'test_id']
    subprocess.check_call(cmd)

    # Read the run ID from the file
    with open('test_id') as f:
        run_id = f.read().strip()  # Use .strip() to remove any extra whitespace

    # Load the flow run and return it for assertions
    return Flow('ComplexFlow')[run_id]


def test_flow_with_default_numbers():
    run = run_flow()

    # Assertions to validate the outputs for default numbers
    assert run.data.numbers == [1, 2, 3, 4, 5]
    assert run.data.squared_numbers == [1, 4, 9, 16, 25]
    assert run.data.total_sum == 55
    assert run.data.max_value == 25


def test_flow_with_negative_numbers():
    # Modify the flow to accept this input if necessary
    run = run_flow()

    # Assertions to validate the outputs for negative numbers
    assert run.data.numbers == [-1, -2, -3]
    assert run.data.squared_numbers == [1, 4, 9]
    assert run.data.total_sum == 14
    assert run.data.max_value == 9


def test_flow_with_empty_list():
    # Modify the flow to accept this input if necessary
    run = run_flow()

    # Assertions to validate the outputs for an empty list
    assert run.data.numbers == []
    assert run.data.squared_numbers == []
    assert run.data.total_sum == 0
    assert run.data.max_value is None  # or raise an exception if preferred


def test_flow_with_single_element():
    # Modify the flow to accept this input if necessary
    run = run_flow()

    # Assertions to validate the outputs for a single element
    assert run.data.numbers == [7]
    assert run.data.squared_numbers == [49]
    assert run.data.total_sum == 49
    assert run.data.max_value == 49
