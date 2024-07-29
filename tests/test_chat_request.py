from unittest.mock import patch, MagicMock
import pytest
from chat_request import get_response

# Mock the get_embedding function
@patch('chat_request.get_embedding')
# Mock the get_context function
@patch('chat_request.get_context')
# Mock the Prompty class and its load method
@patch('chat_request.Prompty.load')
def test_get_response_valid_question(mock_prompty_load, mock_get_context, mock_get_embedding):
    # Set up the return values for the mocks
    mock_get_embedding.return_value = [0.1, 0.2, 0.3]
    mock_get_context.return_value = ["context1", "context2"]
    mock_prompty_instance = MagicMock()
    mock_prompty_instance.return_value = "The moon's size is about 3,474 km in diameter."
    mock_prompty_load.return_value = mock_prompty_instance

    # Call the function with a sample question and chat history
    response = get_response("What is the size of the moon?", [])

    # Assert that the response is as expected
    assert response == {
        "answer": "The moon's size is about 3,474 km in diameter.",
        "context": ["context1", "context2"]
    }

    # Assert that the mocks were called with the correct parameters
    mock_get_embedding.assert_called_once_with("What is the size of the moon?")
    mock_get_context.assert_called_once_with("What is the size of the moon?", [0.1, 0.2, 0.3])
    mock_prompty_load.assert_called_once()

# Mock the get_embedding function
@patch('chat_request.get_embedding')
# Mock the get_context function
@patch('chat_request.get_context')
# Mock the Prompty class and its load method
@patch('chat_request.Prompty.load')
def test_get_response_empty_question(mock_prompty_load, mock_get_context, mock_get_embedding):
    # Set up the return values for the mocks
    mock_get_embedding.return_value = [0.1, 0.2, 0.3]
    mock_get_context.return_value = []
    mock_prompty_instance = MagicMock()
    mock_prompty_instance.return_value = ""
    mock_prompty_load.return_value = mock_prompty_instance

    # Call the function with an empty question and chat history
    response = get_response("", [])

    # Assert that the response is as expected
    assert response == {
        "answer": "",
        "context": []
    }

    # Assert that the mocks were called with the correct parameters
    mock_get_embedding.assert_called_once_with("")
    mock_get_context.assert_called_once_with("", [0.1, 0.2, 0.3])
    mock_prompty_load.assert_called_once()
