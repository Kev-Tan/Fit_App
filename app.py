from flask import Flask, request, jsonify
from flask_cors import CORS
import openai
import http.client
import urllib.parse
import json
import re

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "*"}})

openai.api_key = ""

assistant_id = ""
threads = {}  # Store thread information
client = openai.OpenAI(api_key="")

# Function to get exercise details by name
def get_exercises_by_name(exercise_name):
    encoded_name = urllib.parse.quote(exercise_name)
    conn = http.client.HTTPSConnection("exercisedb.p.rapidapi.com")
    headers = {
        'x-rapidapi-key': "974042ae32mshd59274468328cd6p13e485jsn8464669d0d81",
        'x-rapidapi-host': "exercisedb.p.rapidapi.com"
    }
    conn.request("GET", f"/exercises/name/{encoded_name}?offset=0&limit=1", headers=headers)
    res = conn.getresponse()
    data = res.read()
    decoded_data = data.decode("utf-8")
    return json.loads(decoded_data)

@app.route('/chat', methods=['POST'])
def chat():
    '''
    data = request.json
    user_message = data.get('message')
    user_id = data.get('user_id')
    thread_id = ''

    if user_id in threads:
        thread_id = threads[user_id]
    else:
        # Create a new thread if user_id not found
        thread = client.beta.threads.create()
        threads[user_id] = thread.id
        thread_id = thread.id

    message = client.beta.threads.messages.create(
        thread_id=thread_id,
        role="user",
        content=user_message
    )

    # Send the message to OpenAI
    response = client.beta.threads.runs.create_and_poll(
        thread_id=thread_id,
        assistant_id=assistant_id,
    )

    if response.status == 'completed':
        messages = client.beta.threads.messages.list(thread_id=thread_id)
        assistant_response = ""
        exercise_details = []

        for message in messages:
            if message.role == 'assistant':
                for content_block in message.content:
                    assistant_response += content_block.text.value + " "
                    print(assistant_response)
        '''
        
    assistant_response = '''```json
{
  "workout": [
    {
      "name": "push-up",
      "reps": 15,
      "duration": "none"
    },
    {
      "name": "squat",
      "reps": 20,
      "duration": "none"
    },
    {
      "name": "mountain climber",
      "reps": "none",
      "duration": "30 seconds"
    },
    {
      "name": "plank",
      "reps": "none",
      "duration": "1 minute"
    },
    {
      "name": "burpee",
      "reps": 10,
      "duration": "none"
    }
  ]
}
```
'''
    
        # Extract exercise names and reps using regular expressions
    name_regexp = r'"name":\s*"(.*?)"'
        #reps_regexp = r'"reps":\s*"(.*?)"'

    names = re.findall(name_regexp, assistant_response)
        #reps = re.findall(reps_regexp, assistant_response)

    exercise_details = []
    for name in names:
       # print(name)
        exercise_info = get_exercises_by_name(name)
        if exercise_info:
            exercise_details.append(exercise_info)
            print(exercise_info)
    print('hi')
    #print( exercise_details)
    return exercise_details

        #return jsonify({'response': exercise_info})
    #else:
        #return jsonify({'response': 'Run status: {}'.format(response.status)}), 500

if __name__ == '__main__':
    app.run(debug=True)